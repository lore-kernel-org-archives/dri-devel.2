Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=hhgjCw6K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10F610EA2C;
	Wed, 11 Nov 2026 13:15:45 +0000 (UTC)
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com
 [34.2.82.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A25310E9E4
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048;
 t=1794402936; bh=un6Cg/JaWBewh3OO+4QpLueZbnB1h/rfN4CCfZyiO8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=hhgjCw6KxbR8KjROpxupQ5Q1PhUsWmSU7FEKxL102ymVCgfYm+cXvvpbBQEPcqMSIHrTwYBRx5bsXlLcp32NF+tefUOxSfHJGVkDyF/bUFrOr5Xi+U1+7dBPTfIJho3u4wQc8Ot8soUC3jGiujUXJuJQNbq461NaUsI1wnb7n2wIpsv/ydDOfir55ABz2j0ARwcBY9ErzlakEH5tKwHTWFRByyKIpIkBqv6lPMomFu6T5FWtE9X8mmD9y7z149hAha5Re0+Lndx98/CAAfyOwLBjNTBijs5nqhQ7nKaOrEjOQhEdTyfYlf7KNwcA/E8m8e9pWEbt7xP7zw3BF3GCJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794402936; bh=Uced0Nr1LSWqajptznLpqSgTpzBcUKA+4a9I6wILcg4=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=S51C+icI/ApKiDgo9Am5BeLUgJC+if24zeAK/LjvUi5uYlMQOx6A+i4McKHioy2QOJvyn+x35BDor1ES8VsbRu+bzw+oCtAgzx/VRALYCwJUp1YyRodpyuoFHXDZDzG2CcoSO/BR1dR5rY97qb53zZ7TCbI6WMuMSYuuWy5L07I8VIo7WSFSpPzqulICo/0k5+fgujP2s8NqMi9KkjJQfKH8uCQ6Rnt2kyzLwXu4vPBQJmuGBypNPcMJMD1MMNkvQBr6EpLbOIztCUeBOLH7OJLeGPn7xBlhobRSqR843Dfdf/1gEcBwarIS3dYwnw93tOJbpXYYKV1D91tO7R/iLw==
X-YMail-OSG: d2ZOL8IVM1l3ymETAry4SqG0L2rtmc.Jn9Q5.0Htt3Xv7qxRYRnYDYBeUftyJb2
 11JIOPF0JNr6FIFnohbwoZgkvr00pDB9pEDOA47Wh7IwRa54Ow_.J6Hk.IGiKGUv3wqxgWjGy0Sm
 3TTN.77JCISO5_RUMXcSsNr8X9m79rsN4JsZPxrbYULUruzePtHfU9wo02785RmxIfvuP4AFVzSR
 zrgM3qky7sv3Capmdtq.bHMPK5Tr1KST3Xhkk.bxRORPICMSaxKPMVL5QOtx69p56OISa0pgVhIQ
 yMY78GifGVEr5iDz8NBCezil0ebZdL3WtKHSjYP1VPZXpapWBph4.tIxzJdQW1gbJMELVAu9BPVp
 ouDFMzpTtjV.I6Bj5qnYRRs7S6doh47Iuq0s0y2lKYHIuoWdPFuUyyex5RK_T6wproDSlJUkxVHX
 kCC3whYWD1a8FfQ1nC0q8GX1XYrAEGDHRYcN9vBFR4j7inQRPydfCUo8J6Hz_rwISLQaqKWIoDC_
 1kF.TIbDptGc0lGZaUOwIuUHd8exm45hAlJ0uf3dYV720owHKGZTUvQI1FQBxEmwVQ4wqsJoJ1_R
 169hd.Fc2bOCAk96KtIBFAbJK0dzl7S8K5jOHcgMJX9wpFUHx4T7IQoP7xc.LKt5Cnw805UAKtx6
 dpE0atMGupqxwdhIrRsuTBUOsrLKOipD.LtrroSShDs5qVSe4hdPley4G2AUBiybczey_Nlo9Avj
 RwJPct1o09wQy01e0GXoPDMAsiQOTCGZbpCkKyNsBzfG41hE2OmMx34ljhYL3iLcaExMkTY4Vjpv
 51rzenWwTrknQolQBudWzasGjm16cQWqKxOXgInoBPByKQOoxRiXfukU5lyny0MKRM1V6SvT4rXa
 W6ZYT63snNU..3dJLm5OhPOlbYj_Ly21J8Simi.MpOrTm.VjI3q7dHnoz2amlIDIzZHs6Utk6scX
 HvpB30kf6S2Jxiy3lWYX67XrqzJ3rSoKTgGSTa5MCwE6u24zX0ObJG_hCaA35yAibs7OpkxNTh.g
 zlDoUmzJlbW4biA5bPuZfVN2_vwuTVYA5_65zKwuQpnRFjWK31vKWWW2Uk8ES9rkKTwnmAZ0YBq9
 RxxnwkTby_nsVEoKTmrD.ZKdEhyZNAybVVSz9eSIiGYDvLiZ2zfdaG1Bee_C_OXhq7OE9G_m.d.U
 oCawIFICWOb6rXZ3Gk04DyrmYfVcnEWdu4KsayaYKZzJ8pxTwqXSr06mpZIAlMiQGXmK.USpv_Dt
 3uocnze6gdWiMKZPzeAPe0bJvBM69Hu7FDwGvS.K_WRWeuDVZ5uMNWk4KVugNmMNmMJpFrtUEXjX
 RAf1J_GfvcL_B_Og2ZuZWrobQCDC645qRqTNoEXU21RkExFhj7kE73FHKuXEpZqdxqQ4sXLVTKha
 RM0lU3AxesYl7ZHFR8Du_CQl0oIaHAfuZWB05hmnLJGx4fg7SX3V8X893K2RJJ12mkpug6SsiRM0
 1Nm87olfNLmf0RKQsPEX.PzJOWPAsMvvaLfSfndQYoxTRsg4SWlpbpcdrK7HwPzNmXZxoWphWzbY
 Xu2G6OnGCn7DWbNuaHTuvdisbbXlUnl58utE.gTSMTrACSVvFJDdIF7GWdOPdlI7P0AZT5BuunOb
 EP.2o_yAwmhKvDlJ0wNkhzqoGNpyKkTSIiu54rIyPXtTSC9sTVwx7XeVZXRNx_fjx8cSrGmqxsmf
 P64F1DBzfQ753tz6nNo.aEm7H_U4HdMo6ZiaGU4FZTjTz.emhyuC8NHSer_xkHr9XbmEpBW9DsAC
 Yy2vSlO7WAnxsMm_tgCuXV4NQuaaF14EJGBibq23x756HvsYrSB.2ydOoaSdMN7US344_jZOj7gR
 IBBn63PmHQ30bTpeqD4qujBvLTHp3B2IzZe401rSrg5ksvdKgkVlZLziP1M8bKTtKZvbq9DQhNA3
 cuvi6clY6pXh97miL5u.jSJXEdGiU595l2bqmv1G2z4sk638jIPBVqANKhZ.deTTG6lRVI0O7fGV
 jVpqBdu7NyDF9xwnJMZmmXgxmNB8YM9RIFMY-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: a082e9e7-3626-4fd6-aad3-de587b5863c9
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-102 with HTTP;
 Wed, 11 Nov 2026 13:15:36 +0000
Received: from dip74.lsn.ir2.yahoo.com ([87.248.99.83])
 by hello (SMTP) with SMTP ID 93c53469449c8fb958d76cf31038daa8;
 Wed, 11 Nov 2026 13:15:31 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/vc4: release firmware on error paths in
 vc4_hvs_bind()
Date: Wed, 11 Nov 2026 14:15:28 +0100
Message-ID: <20261111131528.316472-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <ee4989e2-f55e-4d09-8a0d-306b78b9c9d0@stanley.mountain>
References: <ee4989e2-f55e-4d09-8a0d-306b78b9c9d0@stanley.mountain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Apr 03, 2025 at 03:14:33PM +0300, Dan Carpenter wrote:
> There was a bug where we should have called rpi_firmware_put(firmware)
> if devm_clk_get() failed.  Really, it's better and more readable to
> move all the firmware code together so that we can release it one
> time.
>
> Fixes: 2fa4ef5fb943 ("drm/vc4: hvs: Create hw_init function")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Hi Dan,

It looks like this patch was never applied: the leak is still there in
v7.4-rc1. The patch still applies on top of v7.4-rc1 (with an offset), so
I gave it a test on a Raspberry Pi 4 Model B Rev 1.5 (arm64 defconfig).

Normal path: with and without the patch vc4 binds the HVS and the other
components in the same way, the core clock is acquired by fe400000.hvs
and dmesg shows the same messages in both cases.

Error path: to reach it I forced the core clock lookup to fail with a
test-only change (hvs->core_clk = ERR_PTR(-ENODEV) right after the
devm_clk_get() call) and traced rpi_firmware_get()/rpi_firmware_put()
with the function tracer while re-binding the vc4-drm driver.

Without the patch:

  rpi_firmware_get <-vc4_drm_bind
  rpi_firmware_put <-vc4_drm_bind
  rpi_firmware_get <-vc4_hvs_bind

With the patch:

  rpi_firmware_get <-vc4_drm_bind
  rpi_firmware_put <-vc4_drm_bind
  rpi_firmware_get <-vc4_hvs_bind
  rpi_firmware_put <-vc4_hvs_bind

So without the patch every failed bind leaks one reference, and with the
patch the reference is dropped.

Tested-by: Tomasz Unger <tomasz.unger@yahoo.pl>

One note about the Fixes tag: 2fa4ef5fb943 only moved this code around.
As far as I can tell, the rpi_firmware_get() before devm_clk_get()
without a put on the error path was introduced by commit 2a001ca00ad5
("drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code"), which went
into v6.2.

Thanks,
Tomasz
