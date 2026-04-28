Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB9BFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68E610ECE9;
	Tue, 28 Apr 2026 12:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AfFsrtSz";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1540810ECE9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:58:19 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2bd5658b901so637250eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777381098; cv=none;
 d=google.com; s=arc-20240605;
 b=kYXTJGfSCxoe0GpyM33LYBSpyQuCAO/PV5FY07Zcm2wnV7aZL8hJeigCvcmSzQWlJI
 EfE2SPBzisJyqaz+2eVij9xXC1gsP/ePzm70rOoxLKqopMsRRDOMtH5SU4wOP4JI0phI
 dAanjG6M54irq3/yBFz1or2gGv9C2933SUfe9GFL8KvtTxE8ymWqNfHUsFD0ZjXJP4A7
 a/wHw2BWmT9wLZeYsEKDLMbLLYtjVTK5XXvtKpco1nhRr7ISP1J3N4OY/NSiebzMmrsi
 SUtWPWOW3L+t7wLGaiLMZJpE2AMChGZftQUT6WLZeTvRfxBOV6abqLdVLz8Tlh0cnPQQ
 6ZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BdMccuozhAatnL9uzFxJflIeI93nklbA+9rQgir/dZ0=;
 fh=62/HSn+ew2nYbsTp5WAV73UCghYjaPEqPPR16EQHBtI=;
 b=k6gz40Rc/mVDxdkYaZ1jkZEa37VZPdAx5VaaKTkvtKBSju5BwdhaeN/Fh2mSLBnCck
 dt7O7xsMOEocoI286XuRv7V6RuJ7r+iJZiun2TaIN3FUmigK8BRGShKcBeWptIqWjFb0
 nAHV9Qk0BNZNjld+J0NpWI8Q9Wg3DqSr1xytY5LUb9yUYqrPEzx5KtHLFVXPyPa6ysf8
 chdVnr+3rfD/gyKi2sUMduwFpdTdN0nYV/H3e74vNsTCuYpxcUOpf3Qlln3QU/xQzeh9
 wf5HvDlWkY7IKtyiyklgGzNuRDQG3aseY006W6jodD1SH1ONTTkhilSlxB2n1XwhnT+Z
 eNjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777381098; x=1777985898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdMccuozhAatnL9uzFxJflIeI93nklbA+9rQgir/dZ0=;
 b=AfFsrtSzvbeijqnPmPG0KoWlIza/YoQvLI/TznNk71V4kj1Z0n4ze8u9/UMOny2C4q
 BWfDwmk21wI6ZrjQ9BsQt6tK3ugMDYMfB0yzRymvRi0zHw6cOydKkQ/FhqvItoo4ThEN
 ItlxfjQI4IPfSo6iqe16uBLvgCLa8WkkxRInahWL13mlR0ndUwbB6wETcrNnVmCsE88q
 MWvBlkaZwGsPnD8D3eDyZceerVw8guEidXpNJa2r+HLxIqOOPnRmi7Gk45apS6Osy6/B
 hOtenjQ7a0ADNyVC8GuoPIl1107UoafKgoqn1IKNaaoqDrACm4SNsJSsAlp1NaR0c0sf
 Amrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777381098; x=1777985898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BdMccuozhAatnL9uzFxJflIeI93nklbA+9rQgir/dZ0=;
 b=UpemOAP0s1vziA+eCgcAmcbnBKtzzyVZ2l225G4svihEVmAcFJG2UKgEPxnAvIIynJ
 aNA3mOxLCzOmKVDmfeKv1HyPuuIb1oGIYJzalgDsCD+oYuK0AJGZOUsjSMO6PTfN2YQ/
 1jkMyTxwXDIscOkNRtkl+7WyX1EYqp8Pbgv0QgL9zinreIyabYQFH58glwJO82GACmOO
 OrhNxdHK0a2eS2T5w1ExXecI2NTh36PA9a2iCxNWjeHw4sbhf1zyTUny4CnGIJmdJqul
 W1xx6w104h+gVA9yDGjoXNeRjbn7e+9FGvZl2VWgWyxPWWwdi38z7/bjP7ItO+UNnn1P
 k0KQ==
X-Gm-Message-State: AOJu0Yzlyud4QGlaBNH6yoZRxDEFpXnenzDsbf38JlLT1vz3vqZsBMaY
 qiQxWGcQ2Rntzm1zjdooGrmnilQOymOLnl8RYYPzV3QpBUSjKuYf8TDLXha+hOoD7kHKVJ+w8gv
 bzMovuMnTCAjIdxtSFiy/3RkLp5kDnAI=
X-Gm-Gg: AeBDietVFydV4CJSsEfCZ+0+6A4fTxfpgBMKZLddLkeGEWeUuQXO6Jerv1iEofhutGO
 jOJ14g12CzfGBIMOUY+Noqw8j62IRpudz750NRFjpEpWF2QcmVAaSsk42DWhCyUIwv2JyeUmSb3
 nj0HWX27iDqdciJYFj7a/GTPhJcKJhDA5ggUXhfTa8wIijRP7eLQddg7ZYX3B+qQIhYvMACkjEc
 EQ3x4Wojjv3NiCLDIbowBVKd37h7HECmCYOLTz9bC+EqoYgXj7PQk/SykEeT+3bJZ6YZirZPpi8
 ZGLGhgV3JOXbmVv4vbzKfFnVFV4x7zv1usBpQIo7pQb9mnX4W3O2LoTat7OFfiiWAlQxhtNJ4qL
 RtNunjaLNQ5snqq0=
X-Received: by 2002:a05:7022:220a:b0:12c:3ef2:ef0b with SMTP id
 a92af1059eb24-12ddd551936mr655293c88.6.1777381098180; Tue, 28 Apr 2026
 05:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260428125654.3911280-1-thierry.reding@kernel.org>
In-Reply-To: <20260428125654.3911280-1-thierry.reding@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 08:58:06 -0400
X-Gm-Features: AVHnY4IMwmdoNpo02ASuMB3ELFP5Woz2Bz_n7e3WIQLfjaME56CCD92OHGfX8T0
Message-ID: <CADnq5_NRN+uxeACSX89cFtFKXVnp0VkKNeqHv0Q-Cek_YPW-DA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kthread tree
To: Thierry Reding <thierry.reding@kernel.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

+ Harry, Leo

On Tue, Apr 28, 2026 at 8:56=E2=80=AFAM Thierry Reding
<thierry.reding@kernel.org> wrote:
>
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (arm64 allyesconf=
ig)
> failed like this:
>
>     /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/d=
ml/dcn21/display_mode_vba_21.c: In function 'dml21_ModeSupportAndSystemConf=
igurationFull':
>     /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/d=
ml/dcn21/display_mode_vba_21.c:5244:1: error: the frame size of 3232 bytes =
is larger than 3072 bytes [-Werror=3Dframe-larger-than=3D]
>      5244 | }
>           | ^
>     cc1: all warnings being treated as errors
>     make[7]: *** [/srv/kbuild/next/linux.git/scripts/Makefile.build:289: =
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.o] E=
rror 1
>     make[7]: *** Waiting for unfinished jobs....
>     /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/d=
ml/dcn30/display_mode_vba_30.c: In function 'dml30_ModeSupportAndSystemConf=
igurationFull':
>     /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/d=
ml/dcn30/display_mode_vba_30.c:4961:1: error: the frame size of 3360 bytes =
is larger than 3072 bytes [-Werror=3Dframe-larger-than=3D]
>      4961 | }
>           | ^
>     cc1: all warnings being treated as errors
>     make[7]: *** [/srv/kbuild/next/linux.git/scripts/Makefile.build:289: =
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.o] E=
rror 1
>     /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/d=
ml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConf=
igurationFull':
>     /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/d=
ml/dcn32/display_mode_vba_32.c:3762:1: error: the frame size of 3968 bytes =
is larger than 3072 bytes [-Werror=3Dframe-larger-than=3D]
>      3762 | } // ModeSupportAndSystemConfigurationFull
>           | ^
>     cc1: all warnings being treated as errors
>
> It's not clear to me what commit caused this, and looking at the mailing
> lists it seems like this may have existed for a while and for different
> configurations. I don't know if there any plans to try and fix this.
>
> Thierry
