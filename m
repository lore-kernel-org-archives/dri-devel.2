Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDE4CC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC4D10F5A3;
	Tue, 13 Oct 2026 07:53:17 +0000 (UTC)
Received: from host3.o27bbn.ondsl.gr (host3.o27bbn.ondsl.gr [79.129.74.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D21210F004;
 Mon, 12 Oct 2026 11:11:30 +0000 (UTC)
Received: from mail.e-psn.eu (cluster-localnode [10.200.210.1])
 by mail.e-psn.eu (Postfix) with ESMTPA id 3033E3842BC7;
 Mon, 12 Oct 2026 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e-psn.eu; s=default;
 t=1791803488; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+fh4+TCDGqb+p1deMexiH2CF0uJZ6hXG1cZ+wkTnl+Y=;
 b=pdjVKaMBO6v6SiMg+NTkQeeIgnNkJbnkmmOhm3vl0u96JAclj74hMaB+S7HOn7eb2EgJ/S
 t+evWk5VoTUmJvRkYNRGEQ+Dqm+IbgdmI6aYL/aqgghicFK2AONfhn6HOp8gmQ/x1aLJpI
 D9UphRF+Z1319a7sNsHODZjKfG9qc69FVE8JbcD/ThtZl6i6OYdr8KKZ5U0GOH23IJFKiU
 qQIEgND9Ghfbg6AWvKwnKUX8f3AG2HvxB/JkNciahhzPYnc5uMtClWC4VohNNgd4oULoVE
 YJTkh9gDut6rbxmkjAJuWhG7LKVZpeo9JnaMmm3ZOBBng/HJ1O+AtuJTXMJ3kQ==
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 14:11:28 +0300
From: Constantinos Chalkias <cch@e-psn.eu>
To: sashiko-reviews@lists.linux.dev
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
Mail-Reply-To: cch@e-psn.eu
In-Reply-To: <sashiko-outbox-168001@kernel.org>
References: <20261012104245.2108030-1-cch@e-psn.eu>
 <sashiko-outbox-168001@kernel.org>
Message-ID: <4f2e9bd1da1964bb014e5b3fa4fe83eb@e-psn.eu>
X-Sender: cch@e-psn.eu
Organization: E-PSN
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Flag-Threshold: 6
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: cch@e-psn.eu
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thanks for catching this.
On the B70 I observed two distinct symptoms after a sustained workload:
- package/VRAM temperature values could remain stale while the physical 
blower stayed elevated even after the device had returned to idle;
- fan1_input could independently report implausibly low or zero RPM 
while the physical blower was still running fast.
This patch only addresses the temperature MMIO path. Holding XE_FW_GT 
for a short settling interval before the temperature read causes the 
temperature telemetry to refresh and, in my testing, the physical blower 
then settles normally as well.
The REG_FAN_SPEED path remains a separate direct MMIO read and can still 
show unreliable values, so the current patch should not be read as 
fixing fan RPM telemetry itself.
I can reword the commit message in a v2 to make that distinction 
explicit, and investigate the fan telemetry path separately.

On 2026-10-12 13:59, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential 
> issue(s) to consider:
> - [Medium] drm/xe: fan telemetry lacks Battlemage thermal force-wake 
> workaround
> --
> 
> commit a9faaf30cbf789280ad52add1cf188270e8ccad9
> Author: Constantinos Chalkias <cch@e-psn.eu>
> 
> drm/xe/hwmon: refresh Battlemage thermal telemetry under force-wake
> 
> This commit works around stale thermal telemetry on Battlemage by
> acquiring the GT force-wake domain and waiting 500-1000 us before
> reading temperature registers.
> 
>> drm/xe/hwmon: refresh Battlemage thermal telemetry under force-wake
>> 
>> On Battlemage, thermal telemetry can remain stale after the GT returns
>> to RC6 following sustained workloads.
>> 
>> On an Intel Arc Pro B70, package and VRAM temperature telemetry may 
>> stop
>> refreshing after a long inference workload. Fan telemetry can also
>> become invalid while the physical blower remains elevated.
> 
> [Severity: Medium]
> The commit message states that fan telemetry can become invalid, but 
> the
> patch only applies the force-wake and delay workaround to temperature 
> and
> VRAM channels via xe_hwmon_temp_mmio_read().
> 
> Does xe_hwmon_fan_input_read() also need this workaround? Currently, it
> continues to read REG_FAN_SPEED directly via xe_mmio_read32() without
> acquiring force-wake or delaying:
> 
> drivers/gpu/drm/xe/xe_hwmon.c:xe_hwmon_fan_input_read() {
>     ...
> 	mutex_lock(&hwmon->hwmon_lock);
> 
> 	reg_val = xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_FAN_SPEED, 
> channel));
> 	time_now = get_jiffies_64();
>     ...
> }
> 
> Will fan telemetry still remain susceptible to staleness on Battlemage
> without the workaround?
