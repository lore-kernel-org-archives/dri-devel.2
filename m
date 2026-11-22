Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B9606A330
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aBJ6N4Bf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9777F10E3FC;
	Sun, 22 Nov 2026 07:53:09 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AB8810E3FC
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:53:03 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6b8a2518f7cso2579135a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 23:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795333982; x=1795938782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YYjiTYJrCn6f2EJvoqo+mfdpJGY/gBVAph1UiZ3/0y0=;
 b=aBJ6N4BfOrQZL6N7YzN0Ao/GkyGJq1OMbzgs1qKVK5gKgOq8hEQ2jvmIBn9MhVsFbC
 hDp+r8Afuxtdl+hWAUHU4aMVFoudYcDvR+f4q751/aMMrnwxrg/3GghNU1AB/Jq1zBWr
 BMejYJG67KH2WxeFSI5RTPYBWikPhoOHQ9yXBwyPLf7DpgZb5nWkwqgAS8lWfn6/UAMk
 J2bzCHnKYVTNpBy3DGiJzqYKnYPupZHhGwkUuY8vor+3BaV2zUa7MUh2zfcmIJX0B4ue
 bZQBtzlM87QELfT8GugjOtmQqkZNBhNpgthJot6WlK9Owejew5QqsXGwpVmBVUyCwNoG
 4j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795333982; x=1795938782;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YYjiTYJrCn6f2EJvoqo+mfdpJGY/gBVAph1UiZ3/0y0=;
 b=Jj8FxNgMND2M1kPzkJeCpj29KSmBCQATZWIgfDGXJLkmL2XH/2D1I4O/Bs/t6sA+om
 VayTnj+TBhFp705gP0Z55oR67qlpg2diUp7psZrBVpB58DHUVRSErZ7zeMZTanE6yxJq
 ZmcaSPEmHri3z+QWy//qjOYHdEFTL1XY8A/WN6Ur3RkhIBxusdJAlooJUb+OJGGFbPV9
 G6Q+MMTHakSYQeKa4x/7hbJ6cHRAAey5rWlSugTaXCRdpatwbkTP9kI+9pcd8DH+vadP
 qG8DEcOJ8/FYjF+J95+IGkN4Og+83dLfMOSrbnaa91HMxJDOX2XFSoslLTP4Q5PfRwUx
 gsLw==
X-Forwarded-Encrypted: i=1;
 AL+hErGOqtH7dtBCgBhQaLScnGBQg3D/kMVgii6SEqoTzvV6nb86HCsDavY31M66lpnhxGcfGEUb2mh9xY0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8SKYALTvPGo+vbbRm8fet4zwYeV5efcjvvbWZtG8BLmkqZ4z0y
 x7zaZjNjMirgPzDv7XYhQn75I0CjtyWdph4NS3exnbCJiXhlJ82tmL82
X-Gm-Gg: AZFdTZcaafEGOMFWUUsTkmqtE2NdnWBoE3x9lQdPTWNMjeq0erC61xNvBXgj9QY2TF4
 BkLSGPAQ5PEW/Qyoo1zoKFE3DSHOUbdAbJLkYm7uuNt/zNkoMNxZ/xs3PmOehFvchO4KahzTmXu
 x8ukbXp/DZwtxazN0+bNl/1BeBh3yGjS/ZaETDW/wyGcGvZT4NxN0lE5yl23xKVnByc+Gs3V02I
 KucVtMcH7ZXIjVVkPRGTU8x9XnW+5UlyXkSY+xQmDGf3BDTQ0ztLGzxmgMTOEo9SpwieteKOa8b
 8p0O2P1DEiP/CNHPuhRgUMaBjsQLebECxSW4xx1BtqKWw3MrfvJzPVHxmMCKJugt/RTMH8Sn+b2
 b1qu00GZPaNnb22xiBChDw/mnEJp/Vyr0yREmxlNqx1FtmZu5WhTzq7oUOOqWk3xklTvyNpBzNl
 8vdlLmDOBlNljawqlsDQAfFm7JYT4+w7S21znsz/9/TzfVitAoB8yfObxNP6hIOTmvmWKZfCJ9d
 gmdeHcH086KgMCzLpN7OP2lC2yKvLG3/r79WbsXk84QvQxnYSWdXiANHii1dm+ZZ4m813N5f8kE
 X4BUxCilptt7/DU9lIykIaN8BnI=
X-Received: by 2002:a05:6402:1941:b0:6ba:7be9:ad85 with SMTP id
 4fb4d7f45d1cf-6ba7be9aff6mr1735125a12.29.1795333981628; 
 Sat, 21 Nov 2026 23:53:01 -0800 (PST)
Received: from dl360p ([195.155.168.55]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba36e362bdsm3668837a12.5.2026.11.21.23.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 23:53:01 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drm/panel: add Novatek NT36525 (Samsung Galaxy
 XCover5)
Date: Sun, 22 Nov 2026 10:52:58 +0300
Message-ID: <20261122075258.2919999-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179501720308.74840.10845458526829767554.g10-nt36525-coordination@michaelmcallister.org>
References: <20261117173319.1852638-1-tadilhusrev@gmail.com>
 <179501720308.74840.10845458526829767554.g10-nt36525-coordination@michaelmcallister.org>
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

On Wed, Nov 18, 2026 at 03:53:23PM +0000, Michael McAllister wrote:
> I've been working on the Moto G10, which uses a DJN NT36525B panel. I
> have a local driver, but it'd be good to share yours where possible.
>
> My panel is 720x1600 with four DSI lanes, a different init/reset
> sequence, and DCS backlight control. Would you be happy with follow-up
> patches adding panel-specific configuration and G10 support on top of
> your series? I can prepare and test those.

Hi Michael,

Sorry for the slow reply. I said in the v4 cover letter that I'd answer
you separately, and then didn't.

Yes, very happy to share the driver. Your panel is also relevant to
Krzysztof's review of the v4 binding: he asked for the compatible to
name the actual panel maker (ours is a CSOT panel), and whether this
belongs in an existing Novatek binding. With two panels on the same
controller, I'd rather structure v5 around per-panel data from the
start: mode, lane count, init and reset sequence, and backlight source
(external or DCS). The XCover5 CSOT panel would be the first entry, so
the G10 can come in as a second one without reworking the core.

If you can share your mode and init sequence, or a WIP branch, I'll
check the per-panel struct against it before sending v5 and Cc you on
it, so your G10 patch can go on top. v5 won't go out before Nov 27.

Thanks,
Adil
