Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF37FC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3560110E441;
	Wed, 16 Sep 2026 16:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFBIlSBY";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0FF310EC7D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:11:09 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49c5a927a1fso725645e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789575068; x=1790179868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rgu65xROSdjmMwwKg8YIQlif7PhAj3pgiF80j2ZjCnk=;
 b=iFBIlSBYHwX71VfH7/bjuUrcDDUZTFGEBsuu5gEqjkfMgIuT/yARSaynlURjkbpkPl
 BUNvMPUBHbUVfRaIFs7tnGD5fnFOStQBqAGAcSNnsfOqJ68Lwbyl4gAKoNi1U85OUiPs
 IHOM83SKxfFuGWEzVJypL2JZ40iY03SJASY0Os7IcCZgSNK1k8nXxH7f3WoghJLz+2hG
 8sglxqIlTxkL3hAhbv8eUGhkd75hCWpwFV9l4H5MKvWc2zVmZEs8NRsx0Co7nNWBNe0W
 Ecr1tM/diCYHsfAMGHDWGlD9B5eVTijUeTERpOFju3eMBcxFvWlzVpwmB95ABdUK4g8K
 iN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575068; x=1790179868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rgu65xROSdjmMwwKg8YIQlif7PhAj3pgiF80j2ZjCnk=;
 b=ODDOLvEjEa5+08ywLlWtN1niIEFvrcgv28AqGr1AMmlbuFqf4dBcTKTTPDox2K+nt0
 aOFFtK/fhI5/jvh/Zj33BugqdJtWjQzFWvM9SpkhfuDCejbmzGIvpk72y/+dQ+Ux7hPN
 oQZe0ZsUWDZ/dPvEvJ6iKN9PlqxTufgFzoSEPQfjLbgzF7ynqzD3UQ7QnQAtTtwn9sfe
 X3xlugPhN0rL+lPycKRh9td4WhfqSsWcwrfcNwQAO2eovWMz4pNGNT+ZKCt3/3kCeTyl
 R7fZ3XeKwTUDAJnxhM6Qb1e7AVtm0jsj3I1Ye6uPkAixZAsusD0+QlnNGgeM0Bxcmusa
 sXPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhHDv3IvYzNHaosM6uCzYPHOzyxyWekFaNSnPN7Y0WL+JxVSXZ2OQaqsPNu1MXcbAJBYE/IQdLeLg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kwu+ZC2qR1UK/XgYl5F0LbGLpZuHPwZhB1ngR8MtxZBnzXVojC
 kARo/pdlH3Turvoz//HRgYKJgB5H6qpjZi9ke0wtSukYqBAupCbs4uSB
X-Gm-Gg: AYBFou0bkh8isnLH8wHBPwp9fPziH3eBj/Was3yBuyWUu24bw0pG5S+bbJIyKXnPxpP
 tuFaWaTAwfnOa5r8/Ck66CNTqReqp2XRTZpPntRHCq8NyemSiI6kB6LJP6RfqarpVlW/0OylsgM
 zkYuXvZ5ffetNwjZxb/6y8VzDvIiY5QhmWTvKPb/FOZy2zCMKn+xUOAAswpdZ/QpuIcKsaD/P84
 fkUawnxXYzyrRCI/yzhPU355p2Vk51SFsY0pabc+PlNhgtsJEKCXSjF0WbllfNy8loo9IXhhK+8
 pkc59zhngdpW3v45cIKFkETkKeue5m1zwVVyigls87GuQdSPW9lJ8wpSz07jcoFuU1mHciXgVE2
 D0LBXAPoGujlCBpSsdI6OWZGwQ9FsKinnj3cr7pAWurcBFol5LhigH/bmKrRLZ9Lwuc0k0FdUvy
 OTRBUpJnFq5jZXjr3tiuBznHWmAsud719dkkZGQbaoqJw936ocGNGYixMnA31PKU8JUnAo56ZhV
 jAOQ54w25vgESNnxtuWWVdWng3rRS8DvFmCvk0z5WRerw0dNB+DMrvtuMPI/FwxsOiFFDFGsH4O
 Gu3MS+mknQ/U
X-Received: by 2002:a05:600c:5489:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49eb732b2c8mr38610325e9.2.1789575067984; 
 Wed, 16 Sep 2026 09:11:07 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E02002D5AB124699B1F76.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:200:2d5a:b124:699b:1f76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd24774esm2002115e9.10.2026.09.16.09.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:11:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Igor Paunovic <royalnet026@gmail.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/4] accel/rocket: fix runtime PM refcount leak in
 rocket_job_run()
Date: Wed, 16 Sep 2026 18:10:53 +0200
Message-ID: <20260916161053.11926-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915041047.1724928-1-vulab@iscas.ac.cn>
References: <20260915041047.1724928-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Wentao,

This looks already fixed in mainline by commit 9b2dedadf6a9
("accel/rocket: Fix error path handling in rocket_job_run()"), which
is in v7.3-rc1, and the same code is in the 7.2.y and 6.18.y stable
trees. There, rocket_job_run() already uses
pm_runtime_resume_and_get() and drops the reference with
pm_runtime_put() when iommu_attach_group() fails.

Your diff is against the older rocket_job.c (index ac51bff39833, the
v7.1/v7.2 file), so it no longer applies to current mainline.

I checked this with the help of an LLM assistant, against the
git.kernel.org trees.

Igor
