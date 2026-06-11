Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75098CD98D9
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966D610F2D3;
	Fri, 12 Jun 2026 07:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="opECYIuR";
	dkim-atps=neutral
Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D66410E7BB;
 Thu, 11 Jun 2026 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
 s=mail; t=1781191227;
 bh=xOV2aUFkVma787OXRJ1Qw2lSfZjRs5JNr/yEhO5HvRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=opECYIuRdPjgIpdwkhR4V7GXAEPDTsa/psaVl9SkNGp7wRp/EBzAexyYgkdyD3gsr
 NI4YBgL1Ua+wdrdmM5yTIBoSFYxX3VSz419VAM++gbCb1+be0cnFIA/hsEMJI/vrlA
 Wpgb/MKi6b2V4ZsOnaZK9nA0xdmWRS4wkm4malS0PzGS1xsrtuRgugnoCMI2xv5BUQ
 +8ctmlC8fkr7q4jJT3cqHgs/dvZ5QGF+opmGiB7nTTiXS8ZiI4Mg/kgMtqgzFtzcYJ
 ciYYHRS4dYNvGU0tCW7lGtSemZR2wjT+HiWhdqn9WN97DYbzjeYfh+Mt1aRnYAWRfw
 Tpz4ESiVte+AQ==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
 by mail.sms-medipool.de (Postfix) with ESMTPS id CB85A151DB;
 Thu, 11 Jun 2026 17:20:27 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
 by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
 Thu, 11 Jun 2026 17:20:25 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: Imre Deak <imre.deak@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, alexander.kaplan@sms-medipool.de
Subject: Re: [PATCH 2/2] drm/i915/dp: Skip RBR for sinks with the
 NO_LINK_RATE_RBR quirk
Date: Thu, 11 Jun 2026 17:20:25 +0200
Message-ID: <20260611152025.25115-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <airFbeAOC7_czAe5@ideak-desk.lan>
References: <airFbeAOC7_czAe5@ideak-desk.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 07:45:54 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jun 11, 2026 at 05:25:49PM +0300, Imre Deak wrote:
> Thanks for the tests and root causing of the issue.
>
> I think the right solution to avoid using a problematic link
> configuartion is to rely on the existing mechanism which is the link
> training fallback logic. A quirk in this patch would add another way,
> which is less generic and would potentially disable the link config on a
> non-affected device as well (I did read your test results above, but I
> still think it's possible that another device would use the same
> OUI/device ID without this issue).

Hi Imre,

thanks for the review, that is a fair point.
I agree that the fallback logic is the better place for this and I am
dropping the series.

I read the cover letter of [1].
If I understand the plan correctly, the follow-up switch to a
bandwidth ordered configuration selection would already avoid the
greeter case described here.
A 1080p60 mode would then pick a 5.4 Gbps configuration such as
2x270000 instead of the 6.48 Gbps 4x162000, and 2x270000 is what the
device trains today with the quirk applied.
The remaining modes that still compute to 4x162000 would fail
training once and then be handled by the per-configuration fallback.
That fully covers this device, so nothing is lost by dropping the
quirk.

Until then carrying the patch locally works fine for me.

One offer regarding testing.
This PCON fails channel equalization at 4x RBR deterministically on
every boot, so I have a reliable reproducer for the fallback paths on
PTL with the xe driver.
Feel free to ping me whenever the fallback rework or any other part
of the series could use a Tested-by on real failing hardware.

[1] https://lore.kernel.org/all/20260428125233.1664668-1-imre.deak@intel.com

Thanks,
Alex

