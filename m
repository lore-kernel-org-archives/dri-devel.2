Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3722C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD0D10E5DA;
	Sun, 28 Jun 2026 11:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XPmV8Rit";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C448310E3A5
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:55:21 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so1453610a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782478520; x=1783083320; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsVffdBc7bPXV4cXmRez2xscdfa7HYA+uxVYDAWdk7Q=;
 b=XPmV8Rith1nLwAq1u+oeXP1Ouc87ZFMUobr5R6b2gw2qnuOIkx/GAQLCXSbpM3OjgJ
 YQrFsIm6NF7hqGSJJ6dj1rpjO6cJNq/V4N/HHe71CbHOayIJ7h5VVC+NdW+cQBSe7qjN
 RCgpZBWkex+jshF2nlZOdwoKeWPSQhHpb+Zhv/x+ujwanqQjhbasmEwDMtBmoJeUoIYJ
 nEyCyfPV4nLHW3fcbedo8A2Xp1Q3OMxVPyMVRVREaHEbq8ewtIHdkQPlTPm/wxk65KBl
 N01KXKjZil/hBvs9cO76BTImAgYeGCiAf9IDqvhjggVgSpspCAx5I46Cw+xx5Kj7xY3P
 x9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782478520; x=1783083320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QsVffdBc7bPXV4cXmRez2xscdfa7HYA+uxVYDAWdk7Q=;
 b=sKBPZJO/OPfVoDMYMCx4Y1hkvVgKcqmdD2w1+CBWQpfQqhruUhgWkja2Hzngk+5G/X
 izaMod6cDiofnE5folV6vbooGuAzF3R/Sgtonl+tblWerzyVcWzmGQms+g8rY1c19z/9
 g4IS1gdvFHym0y3/H2g1MD43PcWgw1UhFeX7NSvyG8J6BqFOO1NuaSBnoZY+Ia1qTKsw
 PyfS3xUWcPQAfjsBHiDkuiGQiKMbw4xdrF5uQNzmx8r46jo2ixqbadErlNOob/UWPJgv
 Oc6jm80Q3aDb0QySmVE6gxE2r4NhQiZRU5aZg6lRPiYN9xmEbGyWUKkqKlXhi7PljIya
 7ROg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoILYK1D9UMiUwLH4j3XyZx53deBvoqzQkoM5ucmumS3x6nXHqCnozek3DYD+Z4mvGT8KBWlJqlS2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmGNArfnbmA8ZWwwDNM5e1+ELJ4P8PdoNEuFZF+G51g7o4Z6WB
 Rm+R+ulMKTTUOLiing0Ai0Plz5IbAIxGFw31qUGFkndT20/Tk8daQHCT
X-Gm-Gg: AfdE7cm1s3P1SPFA2Im/E2Npp18lIdu9d1t1YUJAVOIQeEFpmXPgNpEPSz/h8/Y1+vy
 toB5OLRGA5072kXwrd7gJH5PhjqmmnVCv+TFNqUDGIL9qf9FKaDbRTsYxeKOLAVnaaniegh5nB3
 8xE7VLVVcvgXxP1oyzEeD5FtUOAdB3Y28pxarYmvTohE9L6yJDb9bpSgViSJdLP5esGgDL9fJjR
 hq8pnhcaKcS0By53Nm13o/jIVdAEbkzbxJR6pWH9pxaxCVroPASS0u6AKvpSmTKj2V0pGebUI3L
 IZdV1ibn88d4ygKhoZjWL0VXb90SdmqefJNRTKtFIko0f5QpiYMGsohoWKOGnQsq8e5Bn7++bIL
 FuJGTl6RTmhiTG/AQW6M1RzVWW6oh7Jvz4E1yVqGotyOnsQafWlQzvmkEXRyWi5+jT7I+dyx6Yy
 UH8lCvgAat8rA84jCrbgYp6Vm2n0KGWg6+PuvwyjkJmRLnJQqRfFIYxflJWBHPryigr5Ogsx7Iy
 lUpEPP+79k81evJFShb4Jk3FDrshBddxw==
X-Received: by 2002:a05:6402:3585:b0:697:f686:80c7 with SMTP id
 4fb4d7f45d1cf-69810b1d4fdmr1909867a12.26.1782478519921; 
 Fri, 26 Jun 2026 05:55:19 -0700 (PDT)
Received: from fedora ([154.66.167.183]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697f46e15besm2750532a12.15.2026.06.26.05.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:55:19 -0700 (PDT)
From: aquiles <achillezongo07@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 aquiles <achillezongo07@gmail.com>
Subject: Re: [PATCH 1/2] drm/xe: count UMA shrinkable BOs as reclaimable
 without swap
Date: Fri, 26 Jun 2026 12:54:43 +0000
Message-ID: <20260626125443.2114770-1-achillezongo07@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112638.2042298-1-achillezongo07@gmail.com>
References: <20260626112638.2042298-1-achillezongo07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

Withdrawing this patch, the approach is wrong.

Signed-off-by: aquiles <achillezongo07@gmail.com>
