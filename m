Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ACFC5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A09D10E534;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NMqQQLz+";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D6A410E415
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:28:39 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d032846c95so50259425ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786976918; x=1787581718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gX78QWNbvx2h9UqqkHHgrawmRxaPgnwHP8OEVorhQLo=;
 b=NMqQQLz+PSE6DFgggkTZPaxoydRsi7g71HMP5KOXBlSU1Y0/h3NNd5rc8SeKUYAcv+
 IIIttYQ2W4fQkU+vnHGu/O+/Wqk6+4PR0nX5WDbJ8cAZSq1qSQspBWXdToYV+kkHWNAS
 G6/3eFJPal5TltN8HFGO6nI36RGqDq9W3PK1/fLm6RN+wZCXesCmCfuNn4Wz3Zp9OEyO
 8ytIqZoXopFK0mmIGox8GsNyUBdRHFcjGs0gSbpKPGb2CKQkwwLKM+HG56IjW10W9AAP
 3Q2SEElz3dFZdZm+XC6g48wbvGR6TLGWMSiUbAnkln9xfWPCxJxxWbxPcloVua7msQHt
 AD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976918; x=1787581718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gX78QWNbvx2h9UqqkHHgrawmRxaPgnwHP8OEVorhQLo=;
 b=DjWD4zOdNrgXu6TnvOKFK5KwnO6qJS4pVyrLKgZp6gzxUVFSTGFXLLFflf0TKSA2Av
 mv9Xw9FUECUqqoYOvQ1kngj1OOlAffAQXj3MpyiL4s0XokyfO0NHbCoYmsqBwqmmsQVN
 kQMYu1/q9inw4YrPFlY1M29+yV2JJII9jDDHmzUTRwVHyEAbTzzMgomfS1xu96fHczTD
 B9cSDg8E0znDR4P4/cWSbyomxmmN3al4GWPPkm/Tenju5nlxl4f9726wKztwj6ehNXwz
 I60RQ62lCVCC4EHRDsD57s7KT9S7Z8F6vE89w62kK6OSi/jRtlRDctsbYbbA1wfdiaUZ
 UtNA==
X-Gm-Message-State: AOJu0YxrUgN8hgcYyAXG5ozJJWwoSCKlb40o0gm6ucYDTuMLi3qZd6se
 Un/NNzbihqmY4Anb0YpfFcS69zMda4itMsfjPQP0JtBnopstHsuSta4=
X-Gm-Gg: AR+sD101P4yOi01U0+gwLDlAomP1Xp67cGn6cSRriTDHEFRD7VKH/fRCRfuFP7ojbn7
 tpD8rfixPYqp7R4eZK2IJF4U4IKGDmf/cP8FFIymA/eYFJNuY6ziUz/eApsUUH3+Fb4ejfIr1v9
 wwIGFvoVbMBcGI21epM1VUZ8g5X4SXTX6kU5VnJ90zCpGz0eVcGLKaNI+tIlTz7u0ie/u6pvNHX
 vwwi1Che34lvzOXPXgAE9ZF5jT/uj42uJn/6wvAekDoTGXzo8SRr6bMIiDjKFmVvR4/HBuMg9Nz
 ioyLLT/2aQhiOjD72PSY8x/Cfv7lrTUyIcngPBRmoSbKUhX7l7vwaTyAab2IURj013/yxEzl6Xv
 +JcSuZ0tlZXeqM7sGEvgrx8zhbW89LAw6bapD9q2t2CmyskmncfUvk6AQr3tHq25fQ8Hqtv1bEW
 yZMJ1PmQIuh3w2ijG2sMSQufy/W6pOyAOJ2CjiJ/q6646TuCNwdwv6O/qTM+VLhdHMcZ4vWFbIi
 E7iq8Rs1BSTG5VfG4bvAPvDEtIoDwborv60KcfS8IR3rT6v/AmhnI0E5XmZ0rPoPkLXrA2lXA==
X-Received: by 2002:a17:903:3c48:b0:2cf:ba10:6d6 with SMTP id
 d9443c01a7336-2d5c4f07dfcmr8469195ad.4.1786976918586; 
 Mon, 17 Aug 2026 07:28:38 -0700 (PDT)
Received: from
 codespaces-2db70c.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.82]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1e528b3sm3807245ad.46.2026.08.17.07.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:28:38 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <89897892+HMTCT@users.noreply.github.com>
To: royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, triet.hoang.dev@gmail.com
Subject: Re: [PATCH v2] drm/rocket: Check allocations before use
Date: Mon, 17 Aug 2026 14:28:21 +0000
Message-ID: <20260817142821.161070-1-89897892+HMTCT@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817093009.22359-1-royalnet026@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Hi Igor,

After reading the code carefully, I think that we can check 
if entity->sched_list is NULL or not, then we can free the array
that rocket_job_open() allocated.

This will look like 
if (WARN_ON(ret) || !(&rocket_priv->sched_entity->sched_list))
 	kfree(scheds);

How do you think about that

Best Regards,
Triet
