Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10B606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xpuqLe1f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8426E10EBD1;
	Mon,  2 Nov 2026 08:04:07 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEAC10E4E8
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 00:10:20 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-35b2c599f43so3670329eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 16:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793578220; cv=none;
 d=google.com; s=arc-20260327;
 b=nc6aE1eN92nNrAUO6etUIMMA9O5cM84q6hm/qzMfAQzTca77pjnrdfdojPE/wcmqFo
 HDeSthJRSAFJ7vDU3ziiHmSgD+9zXk5f+tOyv0q97fk037bVI16Zj0R66trkiJ13g0qP
 nHPw/FMbvpPI/5hKkR+moK7GNfCGJ/aCwe7KImUCfvdzohzZ7gUAayqh+Yrwyl6kUKIT
 Wx2IyQB0XRSX9ADKvsDAZUr8tetJr9DHWci92uPcORKGzvr0ggsg2yoCog3HaAJNzPwi
 WSe8xMlME1gyjiP5Lu329TrsHOS7bn6fr6XWXPRzYKKsHq+H7HpTW12Cw56G4jEd5FFd
 IdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=IxaHOBhBHJELnjR7p3C67+RByc+CNdq09G2SjlGIq8w=;
 fh=rdVGboUKQTe2PQPC07+N7izNoR5Mh+KRwIz2BQB2NMY=;
 b=NIRGjpv2zAU+PxLbZklqpKdyQxG/h3neBBjO9qPvTb7iiHGiREwenKpymWJzr1sukt
 7wW/A8bPOqqlbMbJxUbrUrcM4vNrS6nAHQgInSfZUp169wg94kKBgwgJwC51ONdfSNBl
 FUkFwH2F07xOdqaJd2rd54XQj3A8fuh7kvxWTdiYy1ClUi+x1VqHxvAUUWaLqD6xGDZS
 hYXfmZj3Nl4shDTvHwTEVABgPO+WqAfXqlw8rQKyPjbE6kCEoQGt2ibLc2R0oPDQvGSY
 xdDsatQ1U0Mh05oYhJNJ560aOyNqg4K0+OQi/UVN48rSDEVWnJkEWhJhPu9m9x7bhsV3
 IYjw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793578220; x=1794183020; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IxaHOBhBHJELnjR7p3C67+RByc+CNdq09G2SjlGIq8w=;
 b=xpuqLe1fenagISTlF7UsGYsjLfB4uy/98Tus1Pcs0ScTFCidRYDPC+w4O7qqa08ETv
 PdXB3aZCbHCNQIKkNMfLFLCmEr4b+1qzCxI2YQ45A2f1ykLyIdM/dAwsDX22B+aw928s
 aCkKldD9iA3+3Z/uyoXASF7xK0kdUQUr8xJ6ezku7eStLmJoxTchLDqt4eFw1PcYjfRQ
 3VBAQT0rL3RNsKDfJkR605IufGt16QU0OQF7VdpA0614mpaEKMIJPVQbBz4mRmIlCNTJ
 MxmGhO8ql05R7vm897VI7/cquYTppMdFnqP875zBceSMnrZWr598lyXLSb6dJEjdh7v8
 d+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793578220; x=1794183020;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IxaHOBhBHJELnjR7p3C67+RByc+CNdq09G2SjlGIq8w=;
 b=2djSRiOQFWNFED4bfZp8Fe20WZBQP9Gw7V7J7Ewk8B3pMRuCpIhGak64AOJTMSScMd
 6SSBHAnmXLaQ5EbPR3Bzg0vMm9Bh5BsTaC1il+4UBggHzb5/+1C6HXACYCXgxHMGX+E0
 HmBRqw7yNwzMv6u2RsvXEO88WqMhjDQKoZZCHhCQQFgox5+LcB9mo0E9RTAhVGAgQ8T2
 /OGGV0WZ2stNw260FT4SNHs29YGSWGRR8uPGnTi2kkWF8qaydRgq/BwTURsUsIzQBXWo
 LwR5Hm32Z6JcbEGL9kyNPFkGljTnI4EvgVtOs6S/4mlK6ppBQ3Gup+D4UpWvWAXZ5xM1
 G8+A==
X-Gm-Message-State: APuU4Z9XW97ldaZhhbRF/nydPD+cZrCoP7kR+SxFumxoNw2/AsTyVCk2
 Ha/8g11lutj5jNkjDSgRYYiRp48Sv3G16mnO9sCAhnuJgB9INB0DHzJEnE/8Ubi+7Bu1JA+W1kH
 03FLJyhybxaNRTpozFh8ZxwVAS4t4hFcVBKk6mO0hqw==
X-Gm-Gg: AYBFou3jbFb/Ff1JhxgPpT6It2uhIikwB3ZYuDnoWExh/MhfX2wfKriDTe/8B/yQxD7
 IZBYa+igh96bimihFKAWa6Y0olE1MisW7TR6D2yOVq4fOe7BTnUmcoaBeLoPHyJO9hEP46NLnaQ
 It85FuDDAn5ly+eT+6bBFbWJn/7xsZemOYbUs/8eui58B3gKR2EZoZu3iYhwSjGD+wS2dwfvmVx
 iJjrl7fDvA1PraVMOU/2YfrV1DV4l7p6lBi/EXTDlWgXWiIWni6tIj5N7y0RGi5tWdqZtWFnfCW
 fVxgNAofJCm6c7bZrs2vo5LsYv18atgVLzZn3Pxhvkk5CewmBxXhusIpcmf2x0F0SFV4YkOKZ0Y
 +72V2S8R6KNXO9OeR+Qr4DCjbq3Z2xHfHCZUzF/8TIW+ZBNl5BUdxhQMes+G2oie88Gs5gA==
X-Received: by 2002:a05:7300:ce86:b0:369:efeb:3c6 with SMTP id
 5a478bee46e88-36a4221bd06mr13604805eec.3.1793578219558; Sun, 01 Nov 2026
 16:10:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Guilherme Bember Duarte <guilhermebemberduarte@gmail.com>
Date: Mon, 2 Nov 2026 00:10:07 +0000
X-Gm-Features: AclHuK8ZrCSoM_mIqvArdVQgWt2ODJZ11MQjsoVE8LYZswcP5RmpwKtcj81ZgfM
Message-ID: <CALykNV7EXbnwxA1ofM0J+yXj9wNPf0H81PXXy-ZdqXrEJyaPaw@mail.gmail.com>
Subject: Is drm_log the intended replacement for fbcon? It needs
 console=drm_log0 and loglevel=7 to show anything (7.3.0, amdgpu)
To: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I've been trying to run a kernel without fbcon, with drm_log for boot
output and kmscon as the userspace console. Before I go further, I'd
like to ask where this is heading:

1. Is fbcon (and fbdev emulation) planned to be deprecated?
2. If so, is drm_log the intended in-kernel replacement for its boot
output, with the terminal left to userspace?
3. If that's the plan, why does drm_log need so much setup to work?
Right now it doesn't behave like something meant to replace fbcon.

What I found (7.3.0, amdgpu RX 6600, one DP monitor,
CONFIG_FRAMEBUFFER_CONSOLE and DRM_FBDEV_EMULATION off,
CONFIG_DRM_CLIENT_LOG=y and DEFAULT="log"):

- console=tty0 loglevel=7                         -> no video
- console=tty0 console=drm_log0 loglevel=3        -> no video
- console=tty0 console=drm_log0 loglevel=7        -> video, and kmscon
takes over cleanly

Why, as far as I can tell:

- Without console=drm_log0 the console is registered but never enabled
(flags 0x101, no CON_ENABLED; with the argument it is 0x107). tty0 is
already first in the console list and has a tty binding, so
register_console() doesn't enable drm_log by default. I saw this was
discussed in the v9 drm_log thread in Dec 2024. The Kconfig help for
DRM_CLIENT_LOG says nothing about console=, so a user gets a dark
screen and no message.
- Even once enabled, drm_log_init_client() only runs when the first
record passes the console loglevel (it's called from
drm_log_write_thread()). With a normal loglevel the screen stays dark.
Needing loglevel=7 to get a display at all seems like a poor
requirement for a boot display, and it is not documented anywhere I
could find.

If drm_log is meant to replace fbcon, at least for boot information
before userspace handoff, I think it should light the display at boot
without extra command line arguments and without depending on the
loglevel, for example by doing the first probe and commit when the
client registers, or on the first hotplug. If it is only meant as a
debugging aid, as its DOC comment says, then a kernel without fbcon
has no supported way to get a boot display, and I'd like to know that
too.

Thanks,
Guilherme B.
