Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF40FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E00010E80C;
	Mon, 27 Apr 2026 16:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XqziEL16";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF2210E80D
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:03:32 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so137223715e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777305811; x=1777910611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sY/qtHWBBpZgnUzOnZFEF22Aq9WlFymCTaD2R3vOrzo=;
 b=XqziEL16E0FI5sTf2vH+PwBnDFJnbNhyWLcX4+Opj5gJQrJPA7PPBhaODVPj7ucKV8
 pN956HL4mTSDKYzZV4lRucKxNqO0/R1qJYi0g0eF9cAIsUg8ha0d4ixedtld7tnlSGyV
 Wk2je/cWGZJS+qD+ay+oJ1lc5Ry8odWQKTa6wufqaKkknuxQcln9XHukZUeW+ZNqQ2Fq
 lhAA5Tt+nDsBK/1Yy+/HGrrAAF7EK5SO6CoyVuv74GwEvHd+95Q5UsIhhJcbLfmDes0z
 A+kDKoNowY0FlPsImEvpWz0dCH/5CoNg2FHfLnyJOG6dzU6XjKaja+m/27RU7bUVola0
 TrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777305811; x=1777910611;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sY/qtHWBBpZgnUzOnZFEF22Aq9WlFymCTaD2R3vOrzo=;
 b=fGACApkWVQPLUe/vuEZ5UW0sjXxWlETiVsH200aaZPMYAmj8hXVCW8uEhROGabsRxv
 zPYN7vfV02y7U1oPmfsIyFpgTzCLounRUEnbHrrLxB/1fvssPw1DB0dWFret0jjcV9as
 u9pj10PhGt7q553RSmAAKRF2Ne7w5wYamxSwC0Pg4aF4Ysp+rAbjD1NnZH0M9ElvfjZ3
 qmw5fZE16X7FoT2+GBx+4JIyvbzFfe2RtiExnIF39rY7dFmRoZyGlktwRujPhU/kSD45
 T5hv6gZqBx+8y062EG0HkF3Fqn7Ng5NhjQJPyKmRmnuHJaW2ofDOuCEH1CdJueeGerNK
 XxCw==
X-Gm-Message-State: AOJu0YyiQyxsvnEBdXSvdDd5ZjzCSHmGewtt3YiPhWYYPmAGBvijCVwM
 jxsVM9okbYd1GKS8RdBYb9rYTheVBoyFS9ltWGF7cQ+j9DRMvshpsfD7PBLUrxYW
X-Gm-Gg: AeBDievs6sUi9hnXpv9mA/tp2e2mXIZEttSwWNXwWzJBQdrv4Sd7vfG7/xpROt8cZnD
 gyUA0aXoiI8TFrptSLoHBwgEdbEaR5SFgWj8XwZsxzKabOgEJSMOTLRaDsjpKGs1F6LakvrA41F
 SJhXIhp8Fj8xz0wJiiXvQWQse3wUeXBFeuYiPCljPzeNCgYnEGGcUmsmfM2q8vZXu7ewzz8cQgp
 oa3qYu6whf0uMiU7RkVDJEvp06WsEJzXZjtEWYj2aUJLt+pW5Q//FYmW8SMPBpHRbfUSqj4zSFN
 8RdundTjrsVEVWpUXi2QS0ZGcgocxAHhbU22AJLVS/rvu+W6LEHZAWl6aIItpdsCThOc2vlmrww
 mp3t0Fxs8j6uAzEyON6XAtdxTWEMxr+t8wmvAcK1e4pafE85pOw07TYiLSEIpjNNcEM+aL5FIL/
 SChDA/VPqGoLwbXpvO8KEqtk5dzH+wrafMhh/KcVIrJdbfkE7dqGo85/gjF4ZgLuBzbxylkh6T8
 F8L3E5JJAmG5rCx0IQRvCk=
X-Received: by 2002:a05:600c:3504:b0:489:1c5f:3a9e with SMTP id
 5b1f17b1804b1-48a76f5db51mr28175e9.13.1777305810925; 
 Mon, 27 Apr 2026 09:03:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1d:6120:e343:7f34:3778:d262?
 ([2a01:e0a:1d:6120:e343:7f34:3778:d262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7b2716sm255444015e9.30.2026.04.27.09.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:03:30 -0700 (PDT)
Message-ID: <c4ee8cef-5cae-44fd-8b29-dfc92829a5b3@gmail.com>
Date: Mon, 27 Apr 2026 18:03:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: xorg-announce@lists.x.org
Cc: dri-devel@lists.freedesktop.org
From: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Subject: [ANNOUNCE] libdrm 2.4.133
Content-Type: text/plain; charset=UTF-8; format=flowed
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

This release contains few fixes for build errors that weren't caught by CI.

Eric Engestrom (2):
       ci: fix indentation
       ci: bump debian from bookworm to trixie

Rudi Heitbaum (2):
       amdgpu: fix discards 'const' qualifier from pointer target type
       modetest: fix discards 'const' qualifier from pointer target type

Samuel Pitoiset (2):
       add missing include to util_math.h
       build: bump version to 2.4.133

git tag: libdrm-2.4.133

https://dri.freedesktop.org/libdrm/libdrm-2.4.133.tar.xz
SHA256: fc68f9d0ba2ea63c9432a299e14fea09fad7a8a66e8039fcd7802ca59f77b4f5 
libdrm-2.4.133.tar.xz
SHA512: 
2b8016f64d2553c6cec4870b01820c48eb3985cadc4e39846bcc54db6bcec9435f65ba7749fc8271020317489bc05625e991383569cba803cca85c686d1f4568 
libdrm-2.4.133.tar.xz
PGP:  https://dri.freedesktop.org/libdrm/libdrm-2.4.133.tar.xz.sig

