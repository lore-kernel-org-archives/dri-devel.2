Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CF606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rX3oCf0r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7D81120EA;
	Thu, 12 Nov 2026 12:55:21 +0000 (UTC)
Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2C110E323
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:23:11 +0000 (UTC)
Received: by mail-oo2-f4.google.com with SMTP id
 006d021491bc7-70399d7f076so1363997eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794421390; x=1795026190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bvg45x/n+Rzi5fKhi8+zOb3+1W6kRDRHRptiIt9H8zc=;
 b=rX3oCf0ru+zBtcAIdIU3pN8OH7b8lJ897fnR81/DwAlHjyXigAg7FQJgTG75Ep5Jdd
 Cph3VxsasFUZMdPa1v0GTDPKcetzmzIzKhFcZPV45aOB2OdDT/aFHE6ofiURH9qljR/R
 g2lcCv7dzks06aicGLvZ9Z8qlXX4BAUMUPJcBD19qdNP5kogUFW+o2Rwg7fyMsd3KK1o
 4yjRCXr6ImgTU6oy+DK5FhZx/az0HL3QvjOo5MixSNmQaf/MKwQgaOR113mbK+qx6FJP
 +alUhGwSlqRWg8dgc1I9Lg6rAighvF2Lbt2CFycKMMxnuKffqJgl+rFZZw8yRBSimsoF
 Db/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794421390; x=1795026190;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvg45x/n+Rzi5fKhi8+zOb3+1W6kRDRHRptiIt9H8zc=;
 b=axqfHpH1KIO6knS73nwu4SQMXoUeGyYa4Y+JJCjikmReCLH3MXl2IP8fuULNnmIo3+
 usqsLvV5WtDBWw1NPgk1XUn2bxvgEm11yul4udgOeM2QDZtnwDhBPum05HF+eZyaWUyV
 tZYjstzk1HN4T10Tcs0s0h0CWABUIwKxNo+EZBqKkuHcRfgQG7gSLfqCoiIqsjlvKSML
 q9xSjA1CHn8kmkIIA0v1GJWkn9hVcNd2IB5v6Xc+7KH1Q3rr1SOhXt6WO6da6mqhSXNt
 nSr9RZDpnfZyex5ymbyQND7LRYqLL+Sqw3Pz5CA86WMZTJoOwfmWYqGvzJT8TYB9b3Zf
 cyXA==
X-Gm-Message-State: APuU4Z/JYU7bR3hCB5RnWEar5KEYJY6NpV6jNZv4CJTZ8yt7ThCWJmFK
 54lfFGuGm7frQsdAWEMhMl+N1kKOxjrahcE3gIT6GzVfmMGADNoh+0zmjmlP6VBSWyQ=
X-Gm-Gg: AYBFou34xJ7qCzKScXDIlKQwiIpRLWiwxjwk8v7mKV1cnXh6mGln6a52alQtYdlQ+N6
 yEv01iKOinSj7/Ya+DnPDqsvKO+gXxsbfXJ0t14OCZsueIXUw1mFKpBBVNDyYEe782Bryg/5ac8
 QX4pzg462Ex7t2Xodr+gRfXkJCxR/BZDPzMbT1wd8yTD36lbnLnCrbLY3m88/BkNDDiwkyGj8Fs
 mtbKsMv7YLA2cbvKuOalhJvxdiBR07hqr9CwHJUsoZ+pA0NBkzD8pn28dUQ7yQbnXrh4ThZMIyq
 22VgYpfVuV4Mjd3FNYThXH/GXVfA/D0zTf4xDE0Y1oTb/ubFEXG0nJGJD9GVMfNqSevwj8bC8RI
 AqFe0hDUT7RtT0yek01b2OXVHoxyCu6u5eN6qIenv3EsHcvC/1CGs4iojIHIc+Hri8yuObYC0GY
 0ZTS2HUP3T5s+S80a0HRqnEvgZqE54BCfnwj9FfxIK8NzY4K2E/3kEfo+3t2qNIciXIOUA0ft1n
 LbnmmVvi2APXZdfPcWWvzKxcQilofBFYLwPkmtuq7omVcOKwE/T6M+Xv9KpPmWTWwDw4T0pf5GE
 EyXZ43byvYO7WbQbpUdwNN51o+ANX+U9ewD1d8BDjCMMDt6QWpvFPyk5PuugopIPTVuT5Lt0E3U
 oqxl/ymPnqpAAvCnixYqP
X-Received: by 2002:a05:6820:1629:b0:70d:9be9:5351 with SMTP id
 006d021491bc7-71917892b23mr1816153eaf.36.1794421390391; 
 Wed, 11 Nov 2026 10:23:10 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718a6f2a264sm4474546eaf.1.2026.11.11.10.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 10:23:09 -0800 (PST)
Message-ID: <4d50f769-07a7-4990-9158-f508a6e53c38@gmail.com>
Date: Wed, 11 Nov 2026 12:23:09 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: Wait for the firmware's interrupts
 before stopping it
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261110-rbrue-suez-upstreaming-pvr-fw-irq-handshake-v1-1-8872686d14d0@gmail.com>
 <sashiko-outbox-208095@kernel.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <sashiko-outbox-208095@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 8:33 PM, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> In 727538a4bbff ("drm/imagination: Implement power management"),
> pvr_power_fw_disable() was an unimplemented stub returning -ENODEV and
> pvr_power_device_suspend() only disabled clocks.  Should the Fixes: tag
> point to cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure
> and META FW support"), which introduced pvr_fw_stop() and wired up
> pvr_power_fw_disable() in runtime suspend (or 74ef7844dd8c
> ("drm/imagination: Disable interrupts before suspending the GPU"), which
> added the disable_irq() call before pvr_fw_stop())?
>
>
> [Severity: Medium]
> Can pvr_dev->fw_irq_count fall behind osdata->interrupt_count when
> pvr_fw_irq_clear() is called outside pvr_device_irq_thread_handler(), such
> as during a soft reset in pvr_power_reset()?
>
> drivers/gpu/drm/imagination/pvr_power.c:pvr_power_reset() {
>      ...
> 		err = pvr_power_fw_disable(pvr_dev, hard_reset, false);
> 		if (!err) {
> 			if (hard_reset) {
>      ...
> 			} else {
> 				/* Clear the FW faulted flags. */
> 				pvr_dev->fw_dev.fwif_sysdata->hwr_state_flags &=
> 					~(ROGUE_FWIF_HWR_FW_FAULT |
> 					  ROGUE_FWIF_HWR_RESTART_REQUESTED);
> 			}
>
> 			pvr_fw_irq_clear(pvr_dev);
>
> 			err = pvr_power_fw_enable(pvr_dev, false);
> 		}
>      ...
> }
>
> On a soft reset (hard_reset == false), pvr_fw_hard_reset() is not called,
> so osdata->interrupt_count keeps its non-zero values while
> disable_irq_nosync() is in effect.  If the firmware raises another
> interrupt after pvr_device_irq_thread_handler() sampled
> osdata->interrupt_count (or while pvr_power_fw_disable() sends the idle
> and power-off requests), pvr_fw_irq_clear() in pvr_power_reset() clears
> the pending hardware interrupt without updating pvr_dev->fw_irq_count.
> Because the hardware status bit is cleared, pvr_device_irq_thread_handler()
> will not run for that interrupt, and the next runtime suspend will see
> osdata->interrupt_count[i] != pvr_dev->fw_irq_count[i] in
> pvr_power_wait_for_fw_irqs(), stalling for the full 1-second
> POWER_SYNC_TIMEOUT_US and logging a false warning.  The same can happen at
> boot when pvr_device_irq_init() calls pvr_fw_irq_clear() after
> pvr_device_gpu_init() has already started the firmware.
>

I always manage to trigger Sashiko bot with drm/imagination changes :D

Both of these are correct. I'll fix in v2 -- the host's copy of the 
firmware interrupt count will be taken inside pvr_fw_irq_clear(), so 
every clear updates it (IRQ thread, probe, pvr_power_reset()).

I'll wait a little bit for human review if there's anything else I missed.

Thanks,
Ryan Brue
