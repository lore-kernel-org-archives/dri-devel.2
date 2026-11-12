Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979960A3827
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vxP1ZsI4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12E210E04A;
	Thu, 12 Nov 2026 15:22:27 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9852F10E0A1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:22:21 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so42287075e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794496940; x=1795101740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E8QRxqca6MPKKmYjqBq9RkAfrZBWcYxQ/ymz9RyAO8Y=;
 b=vxP1ZsI4pUQIcUEpZ+FtNhcFk8D+pSgDkepXttZD4kQ42m0NLXIsXUFs11wnCeLizv
 Bu4QytghegFJFH5rHOWuXWDK4/Zkhd9X86ak+pASWG976g2fOFPbWZf8WTI43XNSMsbj
 2G3Xv9fJNOOW1pKrrlexKjPopq0KTT/Xt0l9IzXX0z6t9CuRQUd33RSIzZDUI1SAlAvS
 hCrkl5pgUJrWJ4CWbEUinJ85nfcfPUvmA+8clPVl+sDGhV8Y1Ghz9Vpr4lXd3l3AkCDu
 xRgY+e482N+SMa7ztEy521eaTdJIlm7LyOxiov1S/zMEceaSnWXzYUj8BhHXFpUltm5F
 VcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794496940; x=1795101740;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E8QRxqca6MPKKmYjqBq9RkAfrZBWcYxQ/ymz9RyAO8Y=;
 b=FpEwHvsjfy4olxiEs5DJR7HvTp8uAfSkJQKdM9JxeokgRxUsyJ5K7blxpiFhkPFBih
 pJnYW0KZCvT2SRsHVEdzJYHRFQmTtnaMcfTlETGmyMHMjtz+Cixq0v0uQK1OT/ASDh0A
 l8p//srZlPI9AMF7l2aELj3qH8dF1uJe14RV+aaSVzOjI/XPH2itnREgIACMoQNrzTB5
 6tJqPCYnNgtJkWWBLscQdzY8GQzIis12TZRpbcMdtabI8GSqZJspZio0KjwNYXLRDl+p
 VC4M/cRdlvnUTYotg+nBiJuFByyMpLrb4EYIVOItca9MriLpA+h51ghcfxu6NdLFTZW0
 IsTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEHDgHDuci15pm1b2duL89EQj8QR6gXSD2XA7qmInyQS5xPutz6IA3/soFA5va8pQvjaph+KCpfKnU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+O5MW+Pov0KesqqFyR77dWb7X/XRrP9QtTaVQxBIrRpvnPW1Vt
 56Bm3SQ23xmZy97mSJP+9vMSJ4Cshbxh8BSw6F0f5v3oHWel8678rfzD
X-Gm-Gg: AYBFou3D+kOD9Joili+K/kR++OG2LBNTPLqTRwz++1/5vQipghP08UUg2A3UR2Fmwvw
 2xKJxMOCUGAx97af3kKYarQAzj5nMVwVfxvsPucVp8rjdwfd1v01wRe6XFP12LxAnMjBs6hDGAH
 mF/U62SLODVAt+ZuCZxBpL3sJlN0NyDIHISd5uaS7VqnM/0juq2/qru7oEdC5C4eULSVQnmiIcc
 m44UxSPSaXPlcGfYaATcFKZ98L7NgEIIPNTn84pTX5A0B4wXjj/rKAWc5qngC21Crp8qV0GbzWj
 BSy31Hojk8yX+NlgW3+yOOh8CMmuTtjuI4zTwsZMFhxr0zVcmxIx2y0vKs+0C/CzzzDvQEJHcXx
 iWnJGMoMkl/bva45S28TDGyGSKCn+/vZ+YYxxgxSxnAP9BL1tLWeA+rAbDZQ16Jvc4gthd+q3fo
 nb5NxDwHNWVowdrEINWT57EYLuGqjnCBq782hyNOt4SgNT/ThX65gmCiafvuB3XL4mPFSrgRDeW
 qMKIxhtki2oii+nPYYKrI6uuQbIUIDioBr5YmD7xgMQJxFjz3i3mIR6PFcOdw/d2DH0SDsAtPis
 ALtpLWEf7eCLEFnqJI3PEVuSJfKAYlNhWPHOccwUXUM4E/b4jL5OjV8=
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4ba093a3cf9mr132094285e9.28.1794496939343; 
 Thu, 12 Nov 2026 07:22:19 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e252f7fsm84746205e9.2.2026.11.12.07.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:22:18 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Francesco Valla <francesco@valla.it>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] Add splash DRM client
Date: Thu, 12 Nov 2026 16:22:09 +0100
Message-Id: <20261112152209.3297409-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <066197a1-aa2b-455b-84d8-4e2215fad764@suse.de>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
 <066197a1-aa2b-455b-84d8-4e2215fad764@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas, Javier, Francesco,

Thanks a lot for the reviews. I'm answering everything here in one go.

On 11/11/26 14:52, Thomas Zimmermann wrote:
> So shall we merge patches 1 to 6 and 8 first? You'd have something in
> upstream already and not chase a moving target. From there, we can merge
> the other features in the coming weeks.

Yes, that sounds great. v7 is ready and holds just those: patches 1 to 4,
6 and 8 of v6, with the MAINTAINERS entry squashed into the patch that
adds drm_splash.c, so six patches in all. The DT binding, the placement
and rotation, and the connector orientation will follow as a separate
series once this one is in.

What changes in v7 from your comments:

- the Assisted-by tags are gone from every patch (Javier)
- MAINTAINERS: I'm listed as M: and Francesco as R: (thanks, Francesco),
  in the same patch as drm_splash.c
- the firmware source is now DRM_SPLASH_SRC_FW, and the Kconfig options
  DRM_CLIENT_SPLASH_SRC_FW and DRM_CLIENT_SPLASH_FW_NAME; the BMP decoder
  keeps its name, since the BGRT goes through it too
- the drm_splash_fw_load() stub returns 0

On the CONFIG_X86 around the BGRT check in patch 4: it comes from efifb,
where efifb_bgrt_sanity_check() is x86 only too, and its comment says
that all x86 firmwares centre the image horizontally. I haven't found
that promised for other architectures, and there the check could reject
a logo that is fine, so I'd rather keep it as efifb does. If you prefer
it on every architecture, or gone, I'll change it.

The issue Sashiko found on v6 (a restore deferred while the device was
suspended) is fixed in v7, together with a few more that a later Sashiko
run found; the changelog of patch 4 lists them.

About your Reviewed-by on patch 4: since v6 the work has changed quite a
bit. Restore now leaves the commit to the work, a hotplug while userspace
holds the display waits for the next restore as fbdev does, and
unregister waits for the work before it looks for a pending firmware
request. Shall I keep your tag, or drop it so you can look at the new
version first? Whichever you prefer.

I'll send v7 shortly.

Best regards,
Màxim
