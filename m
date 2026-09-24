Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F205C98326
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2850410F92A;
	Fri, 25 Sep 2026 07:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CHHZwAON";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2769E10E387
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 17:13:31 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso407015e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790270009; x=1790874809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ij7MAN7W+YzHEW+px1HCxBjC06Pm0gT3zC5V96sK/OI=;
 b=CHHZwAONNcixl+8TBPkW0hCWDLCWV8y/xHztCSo0BC1+qYQOhrImELInPbGqupZijp
 9Q1JB4fXydJGqTaNz101ryl89FNCRld3Mt/+pbDbSG/WG0CRaP6nzwxkLk2vlsq1CsJn
 BYtmDpEXf1rzDCt1qMhEZ3DIxCcsanVxFL+MrBGY+N+X+aGfEL63MuuAmv9m6Aso4T2I
 tmTAHD1Vfe7g/SbyW3+6L1quo33NnqpxUsaiXGKKeLUkApwEz6Oz8/cvDFgKUlUWnW90
 CKR4CF8lnnh/CkwSSgMGyVQdoBz7R045Lm8NTjdbi0xppLWh3MW0eL2kX+GcpVb9idQi
 jTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790270009; x=1790874809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ij7MAN7W+YzHEW+px1HCxBjC06Pm0gT3zC5V96sK/OI=;
 b=tBiw5wmGjkOdVeMFn8kCujz541pe0/T2kpXaCWBiEvimbZ5vfCmiREjnd4p89dJAkc
 xko40VNYurRG2KdOiQlTB7ks0HfZPzRKLGwLHYv6s8+NXQ9e9CDMc5pN9F/t+7Xn8XND
 Adjq6WJwnaZOJYmf6+BC6mxb3QMZBqvCYElBou+lYP7YcgNkByOKyNvES9Pa/vM27g+X
 UO6+FgTIycNNk4EH6awNzcV+P+Y0wH17MoD+UaA3K2+n7s75tz50GrzwEIW9AWM7gYbt
 2zMMilfJPGuM+eensaomXjh24YRDDtcm3bfRKX9MOGERVefVQZ0c8GiQ7KZPPp5Wt/BM
 NyHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6NVYceW5O0kx1zWA1yKJI7z68IgEAiIYpdSvmbJEzhopqBgixr0G6qF14KEVYbr9m+ZizQoLkkIo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++myzQOQlGNu3KiO4roHXMzv4pbhOmfIPQdasBoh4wylZ9RTpAzz
 vUq8xGzh12s+0CiANnhZhIgmZuR5M5X20c308g9Ps/FQWCPGAF6BTUks
X-Gm-Gg: AYBFou2JeLnlkR+BNhe5QHhWamJnnviUfisT1X77lj4FgkUN5a9n3PLb9G5xT42A3NY
 PO4dtvAeXbqhXjJb+OBJkZJoP/HDjxQYrtEEBMiVncpJPFxS+e5SEUopI9PaWgQrxj2ArQZu0eW
 8hmjj1JI68jF844dPlIz3G45ZeNFPWyonKDm/tDCfywoiYMqZaFMTrBx/E4QKNKmGt5rsrRaeVJ
 TE1JrXjk4+MchOQyV3DYnURbScoSxIBNdVhuyeuHlbW5EJn5/RLiaq2KFI64akmNwVepFzuEg6O
 P6RPoxlwN0tm0axmpyMxdAKK2qNxwqQSwqDwrPe2KgP2hrBCuhiIhLaM1s8PUjX2aNLqP2uv67q
 DT5yl37X5QbFbpgIh1bId2ej/I4s8MKiuYcwKvkQCoY8/9nIjl6WT5+rFrIR3SB/uS1P9dN2d5V
 XeW72eGHhbL4bTAbvJvW/rly86583Aigj7i05bA7aScxirF6tXFUXBzke9y22jPjUxA+Zf7IoVb
 w8=
X-Received: by 2002:a05:600c:1d0d:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49fe66f144fmr56773715e9.16.1790270009307; 
 Thu, 24 Sep 2026 10:13:29 -0700 (PDT)
Received: from NBLK-WAX9X ([2a00:1d36:5f19:6e00:eb69:2262:593:ab12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd42f2sm86170695e9.15.2026.09.24.10.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 10:13:28 -0700 (PDT)
From: =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Jerry Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
Subject: Re: [DRM] amdgpu: HDMI FreeSync not exposed on Samsung S22C31x
 despite AMD VSDB
Date: Thu, 24 Sep 2026 20:12:43 +0300
Message-ID: <20260924171246.17280-1-atailhan2006@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CHXPR12MB999220241D7681B15420FBA721E5822@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260923002718.5915-1-atailhan2006@gmail.com>
 <696580d8-cf2e-47aa-8616-7d930c2f5b82@gmail.com>
 <CHXPR12MB999220241D7681B15420FBA721E5822@CHXPR12MB999220.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============BOUNDARY=="
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

--===============BOUNDARY==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Alex, teapot,

Thanks for the update and clarification.

I've attached the raw EDID blob from the
Samsung S22C31x monitor for reference. 

Good to hear that the transition to public DRM parsing for the
AMD VSDB is in progress. Please feel free to reach out or send
any RFC/test patches my way when you need validation on this
hardware; I'm happy to test them and provide logs.

Best regards, and thank you.
Ata İlhan Köktürk

--===============BOUNDARY==
Content-Type: application/octet-stream; name="samsung_s22c31x.bin"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="samsung_s22c31x.bin"

AP///////wBMLRBzRjdONQEiAQOAMBp4KqHVq1RQpCUMUFS7jACzAIHAgQCBgJUAqcABAQEBAjqA
GHE4LUBYLEUA3AsRAAAeAAAA/QAwSx5UEgAKICAgICAgAAAA/ABTMjJDMzF4CiAgICAgAAAA/wBI
OURYMTAwMjEwCiAgAeQCAxyxRpAEHxMSA2cDDAAQAAAjaBoAAAEBMEsAAR0AvFLQHiC4KFVA3AsR
AAAejArQkCBAMSAMQFUA3AsRAAAYjArQiiDgLRAQPpYA3AsRAAAYKkSAoHA4J0AwIDUA3AsRAAAa
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA8w==

--===============BOUNDARY==--
