Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DC0CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEAA10EA70;
	Fri,  9 Oct 2026 03:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C5+KFltK";
	dkim-atps=neutral
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C5C10FE10
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:03:37 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5cd7bcaf81cso2853761e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791515016; x=1792119816; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dY+07CnYbuDTOMQpTAwDubObYAClkAAr9Kwvv3Zr0Ig=;
 b=C5+KFltKRZUW2VJuaWWPfi/EC4aV8/umtSNjTzy4K3owe3AdmtsHmqPBB4jfHScUFc
 JpgCMsuiCbskkTCQ9ysEOjc/yDEPWEiXcpdLBH2hXWID60kjmwUMEeHksTzSP84uB/72
 pTm1EoIX+q75+NPOGQOoecOE1oqV2G1O/BtynIP3PysXKpVRGYcnCBV+DQlNqzxIUofx
 +YvfOXyvpe6gUMibChku0PiTfHVCHeIzhtZQ2fszOxccyJmYEoP8ufWf/EKKISgffKY0
 Tokd79VzuV089pb3TC/FmcV4MdNwxLVWxlERw9udoQH20EByKtXtXEPoQdpFBryU5odb
 l1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791515016; x=1792119816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dY+07CnYbuDTOMQpTAwDubObYAClkAAr9Kwvv3Zr0Ig=;
 b=susWM/rn7dSnND6CnEeLFV/qoLh6z3q0UOz9EhCMkzDde2NCqZ8w8V9mbO8UtL95J7
 cJ5F5AK9D478lMSOL6hfDWYE5FoInw9ROzdY1nifqzT4nsQ86BxfdfRWHRIVgAclrcWa
 a22THXrSQO8nszGt/XANjAG+bWnsNf8onuTOZvmvyaBZInqgLSo9RFSCQdCenGDQhXsN
 Q7B0nTiNVzh7ItKu4lidfOO845XUe3HOFAt0gFZX8C8+O/dnKCrQNI4A8fCELdbHIA4T
 XqESIYVnojBNIo6Hvtlizu1uOjKmhfcjerQjl7+DIAqycRU/mLxe0PGco+m+dS1C5XHD
 HbnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByAsb2iJIQfN4PtaUtywE9La+DD23Q4iZ9adxFJg+BNctjwbBmTA1uuF/JBGiZz+nnD0DWwij0v8MQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLruCeul51fbzsByA1adQrIGgsmxEP89HybssTzISMpPUx6a7Yg
 DGzE92RkoVKxGeovKDg55buF5V/qedXvIF2DrwLVy6RKxP8pBIx5jZsj
X-Gm-Gg: AYBFou0mryBMOGtmZ/Ae1TlUhpjrPkUmy4FXIwz0a/m90NpqTWK07O6/0EbuGR4CMEA
 NvVjer29HYnE6sWWi+opgsc3MNcwB0J0d/PmV+CW81ZU9ckohI/hA/02pt/fVE9uMok28ayAMlK
 kP0t13BLiFKlxj68G854lo3jXDEXW80axP4qB6hU9LK3T5Ouw6+5TV9kyrndxterBg3xtU+qzLs
 k8iYgiSWDbqrPbObybHEC/MHNhEGRL1l+lLw/RwWomz/s3VfIKkE4u1lH93xftMitkQZOlzI9xe
 3UFa63gDqsSSEupCB/eYIccvSZDY0daOaicAOUXZezmPo5KDI5/6G4u9G4XjxQmKID3xC7RgAqA
 t+I2epD8dWuEjM/HTsg9ryLAGA1mXrY5Js8uQUp7Mf+FCMLHw0iAxLPDJn4r+noCMSoxXJoadWi
 EjHS+HuCfwWxtinPvu/TEMUDnnVrfC5Em751ZHfDEU1Zd0mbSvLjqJJJgKgdMvNgY=
X-Received: by 2002:a05:6102:548f:b0:7c3:83a9:edcd with SMTP id
 ada2fe7eead31-7cb397160f4mr227448137.3.1791515016575; 
 Thu, 08 Oct 2026 20:03:36 -0700 (PDT)
Received: from beelink.. ([187.13.210.57]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99003ae1577sm814626241.0.2026.10.08.20.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 20:03:36 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Fri,  9 Oct 2026 00:03:27 -0300
Message-ID: <20261009030328.3062630-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923162839.1368073-1-qwe.aldo@gmail.com>
References: <20260923162839.1368073-1-qwe.aldo@gmail.com>
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

Hi Alex,

Friendly ping on this v2, sent September 23.  It fixes the dword/byte
mismatch in the ATOM PS index bounds check in atom_get_src_int() and
atom_put_dst() -- the sibling of the calltable underflow fix you
already applied.

v2 also corrects the pr_info() messages to print ps_size/4 (dwords)
instead of ps_size (bytes), per Sashiko review on v1.

Thanks,
Aldo
