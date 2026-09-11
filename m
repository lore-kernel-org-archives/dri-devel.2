Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC7EC88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFAE10EA0D;
	Sun, 13 Sep 2026 20:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2ASSNk/";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E5F10E405
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:07:26 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so1453076a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789153646; x=1789758446; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DKCNcuYe/SKPUXfT+hanHdMYg5xRT408M4jqZrd8Y8Q=;
 b=Y2ASSNk/eFpUnKHJ2EP+v+i0aStrLpIwXRb+nhxrKW511IGtVqXuvhy8TYHiiuzZGG
 wjHH0K2r0S0TE5PT3pSBwezH4/R2MmWZdXBDz2ZXPkYdLA3JTYu+WBs9JfTYEHitlFJq
 lji6L5G5KDkvdhGG72BZkJ4Ookg47qLzrn4mb845s8LpecHrV6ivEunFp3bHtvcuw5dJ
 WecTCOa8plik09iOfO99EAqKlK8CuFkG+y7TkZMt/AlDpqHDFheTMiaYJaVSntlkjK2p
 RKRDOPy/zxnVnYHdcUJhRb2S/FPJzA66MdbPXriB4o2gQFdEVdRsMUL9ShmtWr1plsRp
 oeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789153646; x=1789758446;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DKCNcuYe/SKPUXfT+hanHdMYg5xRT408M4jqZrd8Y8Q=;
 b=ci6bhxnbXpvg7AKz749QBw0q65D2S5ysUbVv5xVprHW9vZdUMLRHIleAiMTW5jRN/U
 5MxP509PYLCtW5yj0wou07YD45lKp/3RHfwLFu/RiFC70dFTeDXZaD1sLwleIG1BbO9V
 h+Kfl9+OdY1xjfBh9SG8ZJfMSwZKm3MWAkAkZaXkOLS26sC23b7sfnJ7AJKVrLCddci8
 8EY4ZOf2nUIg0ejeC/RQyAAbQNL78ypANBKJyFnqiQLm1v3dYkeEza2gGDnLiBhduMrJ
 T1OGblO0bz3ToRFRCH+/U2KsUzWWEqJBBzupun0w/Uy6pxlMDFWozQUsJ3QvngfNx0sE
 rJrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcFTuH4hqGHq7Ja9NWCoa1mg7r7yb/uC8miT9Yp/EKiSmj1OE546hnKJsRZYTyMIhbOocUCRT/6/A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ni/UeBHVVieq7y8J/pF3v4R6AuCT5cCMAY6f0Nz0ggvzWqpm4d
 xLr3aa3GtjCsV9JYGFHNaxrCMrqRjzEL4e9BHnTxYsQIFUdWbFD14VE7
X-Gm-Gg: AYBFou3oWmCAYOXahK1k9M4EHBBD8Zo6Mr/aWvbLdJdJwIcwJ82M34KeF6ocjq6mTkH
 bPIJYkCbyJiKGj5Rg/3GE2AaQk7oRLD6LJ3da2izHwWjJq8+iwgkgQr+l+U33U7H8js1PUx1Xwe
 vt42eMIzYc/p3YzXh9uL2nRPiyK+v1HVFlLXL9/4VqJ6khyi2CQVV2S8awvaQVLvC11UOYvgd5L
 FLDf47CR1qZ/70YX4dniStDU+LTx8qx4/lII5gRrmxnKA58VcEV6ac7mVaJ100/s4rsvqmt7uGr
 iCh6vz11yo80JDxNWqDZqMmXnCiX8Cl+2fAgidZfaT6MO57RuOZkqe3Cpm4F8hNSPQaQJcSqYpq
 gmt7PxcLe46y2D4qkzviyZapsLPTKbjLLCOHtdKpWN7xGdZxZHy+h9WYAjARqbJfhWSD24kbAgf
 2kXHU+4Rc/bENXTAciE/iDLHn/KNAMsavRlCT4yWYbWSP75VID/+pWlg+4GTIyBA3VTEca4DXvn
 c5P
X-Received: by 2002:a17:90b:3fcc:b0:38e:a52e:a3c9 with SMTP id
 98e67ed59e1d1-39d7795b9aemr14379383a91.8.1789153645830; 
 Fri, 11 Sep 2026 12:07:25 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e51449sm7185033eec.5.2026.09.11.12.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 12:07:25 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Ze Huang <ze.huang@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
Date: Fri, 11 Sep 2026 19:07:21 -0000
Message-ID: <178915364143.207017.11386693869817053993@gmail.com>
In-Reply-To: <CAD++jLk3Czenn1DdgFGGEwJHQQ9ZrmFng=fmih4MUP8NaRGx3Q@mail.gmail.com>
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <CAD++jLnAoOaRwWpkVX0o1z0wF=Qs9PRTKbq9iq-GWSkJ2kyX8w@mail.gmail.com>
 <CAD++jLnBPAw9CJ4JtZt46yBd7+UEHYA189Dma3tNfuV=wu1TDw@mail.gmail.com>
 <CAD++jLk3Czenn1DdgFGGEwJHQQ9ZrmFng=fmih4MUP8NaRGx3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Not quite. I tested the newer iteration attached to Thomas' earlier email
(patch dated Jul 27), which Ze hasn't posted to the list.

I also gave the v2 4/8 you linked a boot on the same QEMU setup and it
behaves the same, so the tag covers either version.

Tested-by: Roshan Kumar <roshaen09@gmail.com> # QEMU vexpress; v2 4/8 and the=
 Jul 27 iteration
