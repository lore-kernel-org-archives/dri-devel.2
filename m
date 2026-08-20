Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13ACC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFE610EF63;
	Thu, 20 Aug 2026 08:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+YpJSDr";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E98D10EE11
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 01:31:29 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2658992a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787189489; x=1787794289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZYfbK1hsN8pqS0VkpL4NDdd50NbE1kPEFR3ZIetPkMg=;
 b=U+YpJSDrQtRsZSOHI4d1TWBdCVOReM3bPTuHquMqwK7cA1c/KWjVpHAnCEIfg36ILt
 TKusC4abVz17QnhOZW3Jw2Z1vlDP654VpDXVEXSHhKe5qv7KhmdyV4XiwRbnRIVNBWMU
 lyVxo8PhWD1Y/nRLSYw6AaNvR0D0xcLGfO6W88T1qgBVJklk93ydD1NdO7CZD8yl+S+r
 Q80CQyezpeMhQzZezjdnj9oJmgjf2sOXGB6lUtH9bw960l7nx9eQfM1xsz9/hlzKYBcf
 2Vw9sIdZ6aIG3fng0Oc4Okkr4LnViffvbB52gBDLG1Y220cmq8XVsQWKuw0UquZ1mWvn
 P5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787189489; x=1787794289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZYfbK1hsN8pqS0VkpL4NDdd50NbE1kPEFR3ZIetPkMg=;
 b=je7gNhc1hlxif/6iBA1/4uXRDNqmVKG8DYaQD/8rh7wWu9NoMz5OSlh2/T3F0MJtsn
 +dZtsiszhBne9B8iz7DuxJ5MTaqlEu3MnH10RwHp1PX9mOHs4rW6u2L12bOy7xThTHiH
 ov8E2dksKLVQ8STMJeKVK18w75nDjEpippPg+cXLTKDUNWHf6eWx2uKXTcbwrtlwD6/+
 SJm0IsZQMUVUIZaG32Vtu7XVev+xTVFJaiK96JniPnu+ls3O47IfKc6YhNAO6tWM0bsR
 XLtuNptijdJg9nPQ7iGYJ7B7Is3xOFHUk7UqHGHVnUH7VpgULWo3fXX/FC2zQRJWhVGt
 CRTg==
X-Gm-Message-State: AFuF++n8a2I/NzBX+0Pfeb+FEBrz6HQOLRQw6XtLy5mVxcuqeWPKjzMO
 Ln9gsohC1v65CLGR33CauCI3OzCVJHcDBmf2SgRgNWxyT9wrLCTzMzc=
X-Gm-Gg: AR+sD13aizcRY3vVgVtcY6HsIS9ADr2NJAbOoGSX/siNY1icOwV0I555w/5wCqtsG3E
 fw1vxcTFHv1Lmdgo5F3Qw0eAeVtrGEh5j75nCvOnMdS82c2Wy2yPZpn18xN+8Af/AJr9Tdc5bDS
 D07iOpXcyx/LnXVzQA7Rb+JMVZpL2lyjDyyZf8ODY+1+cf6O42BAKRMeE1BSRFtFbpwwKEbHbZ9
 iLN/sEcRdTgEvIXSgdzYUg9tlXzvvGLgfnMZiy8TCioZllNQz4FUZEzm9M3bmLewFjvVMEvD340
 TmfWP9esBMqFusl+Rz+7dJPKLD2+cKaOtbF21xX7s1CEBE56TvK8IyrXPlu5NPv4QJCYYWX1H2i
 KaNJcG9ILvGQiM53ZVOI5M99lXw2fKSiwsyUUc7zN/DITgLtMO3CLN59r+IY284GOuDv/RNH07K
 QrKv+HsfTXEzpDDqSYXCUP+SzrwLpnpuYlX/0OIjiD7g7h5bYhDcHgyxJgZ6rfjoG+VRO5tF1a7
 Q==
X-Received: by 2002:a17:90b:1e49:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-39580f6c037mr15239586a91.10.1787189488911; 
 Wed, 19 Aug 2026 18:31:28 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395ada57c39sm144933a91.3.2026.08.19.18.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 18:31:28 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
X-Google-Original-From: Triet Hoang <triet.hoang@datalogic.com>
To: royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 markus.elfring@web.de, ogabbay@kernel.org, tomeu@tomeuvizoso.net,
 triet.hoang.dev@gmail.com
Subject: Re: [PATCH v5 1/2] drm/rocket: Check allocations before use
Date: Thu, 20 Aug 2026 08:31:14 +0700
Message-ID: <20260820013114.1443742-1-triet.hoang@datalogic.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819163509.5743-1-royalnet026@gmail.com>
References: <20260819163509.5743-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

Thank you so much for testing my code!

Regards,
Triet
