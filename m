Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DEACA6017
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A89A10E177;
	Fri,  9 Oct 2026 00:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="UROCiQv4";
	dkim-atps=neutral
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545F510E177
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 00:01:21 +0000 (UTC)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso2862233a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791504081; x=1792108881;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eQ9gPc8GMtuGw+jgy6osNNuy5Xw9rr9Ot71+Sg0ZxL0=;
 b=W/cJqpnhE8qvS7EQMRua4HIwmNbwW47nx/1MffSEKFxz3ere3c/kwdXrMVd9NsKRa8
 brxvQ21wAIISYnbsEFjHp6ww50tXqcPZ9sXAhSoDiju4MZQ8CiAQKOR7trGzNFN8ADIF
 8MD8NN8hPrEKd0wQgTy2H2TICZiiUE7qABUmOaoFZuEzCzF45vEFm59wCewyApHTrCW+
 Cp36IyKLguKywrOeMuRu45rKDFu/h680qMdz6eCfwaZWT4omuh0b9LcIXxrT5dXuEgqg
 I3bXeMU5p/HX7ATY2/+rHrBD2HkBt1ea547dTWfCz/YhN/Rrir9DoQ6WLy8TmA+ab+5W
 P9LQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKcRsENsPR3+yIDFaKvmPCvpwOdgG29e93cmiApCRzjgGZ97AsglVaxkTgFulCHnEIVlnyHS6Hg9A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJagpRLJdUM873iUWe0C+iBkKvjfmhvRQChNZox7uzJAMJrb5Ni
 pKAPeU/+AHHory363mMOiB4fyXRyGdapkENwrofSc6Q90f33ZuKkGKGefm39MAxy8W7fl3uBBlq
 kRsqJULMPdHShGJw3IvybUcEsc0kNzQReomWKDScYWBF9sMwfQQnthxv1MjghAeO1Dz5Gy+Tm0S
 ni2/hHKA4ISFgfF+1U9m0s6GSYDus9avA3OJH94kmMLe+6wHc9kthn2IlljhGlwIpAnoukNSao8
 /yqqxtdc/MnXlcsJaO9c9K6fJmY
X-Gm-Gg: AYBFou3rNPxcm7uWptOAPXFTrpHs9khf8vRdJ8FGTmpv7hFS4ZvNxWNF+xfzRA/Jo3R
 t64rHAcNKR20qpbjEPWyit7BvA4WqA/cyu0+e6IWj8hoO1SqUBcWIwbIxrsjp2Gel1qblRbSUjp
 rGvW/6bIIx6vy0nHswkFLYLtC74hmwCFNJgjvFkQugQNw/GRvOzZxNph1Nj8WOOhO2u9B41MUKS
 hgsS3gdpMcz+81/DhogzD2QJilA4KKa9xrrJTnmRz7glHvBTv9Ukn136ui0qLOjdau/CUuQ9BPx
 O8jnau8CfzsKjCexjKMgPCNodR2XqhkFHGFNIqfsTH9o3eAKPE5MwEypFh3Z+iIswG0K/3WbStw
 x8IHlAs4xXHi04fDOuOkHos7/MbPViii/mpf8MaEOxx+yM1b1wmIyGV2KEIdNlmabwP39oAVWm6
 AUkd5Y1KHDHCahaE6aohZhCSgf28y5R+MGFi3HPxHkEIo=
X-Received: by 2002:a17:90b:390a:b0:3ab:413:49a9 with SMTP id
 98e67ed59e1d1-3ab3a932609mr370642a91.50.1791504080108; 
 Thu, 08 Oct 2026 17:01:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ab395531b4sm142500a91.3.2026.10.08.17.01.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Oct 2026 17:01:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so11726644eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791504078; x=1792108878;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eQ9gPc8GMtuGw+jgy6osNNuy5Xw9rr9Ot71+Sg0ZxL0=;
 b=UROCiQv4Daq0W5iIw/Yk3WORnDLFWR0wk20dsDQOrGd6R4nUWbdUQgB1saccvjtkNU
 wv9kBu5ABVI6tbVbRDE5bKxGpJcz7InuLfqE3jPzvSqQbq+MfS5TfIGxhVxI1XbSoazw
 8/RAtTjJLtKsH585/u7Wus2M+1dW9Q7fBBlXQ=
X-Forwarded-Encrypted: i=1;
 AKwUvByYDuAGKWpNExa3YRuYXlcnIOkXRrMslrzUvji/eZ6b+YuMb7N03uHUrgBtDIAGg2kQFaq7RxXU5jg=@lists.freedesktop.org
X-Received: by 2002:a05:7300:ea0f:b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-3537dde991fmr644025eec.1.1791504077138; 
 Thu, 08 Oct 2026 17:01:17 -0700 (PDT)
X-Received: by 2002:a05:7300:ea0f:b0:34b:7c9c:9a71 with SMTP id
 5a478bee46e88-3537dde991fmr643952eec.1.1791504075878; 
 Thu, 08 Oct 2026 17:01:15 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab786fsm1578849eec.19.2026.10.08.17.01.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 17:01:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 17:02:15 -0700
Message-Id: <DLZV7Q47B0NY.1E83HQV0P64MI@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <zack.rusin@broadcom.com>
Subject: Re: [PATCH] drm/vmwgfx: Make vmw_bo_driver function pointer table
 readonly
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Ian Forbes" <ian.forbes@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261008141501.2182964-1-ian.forbes@broadcom.com>
In-Reply-To: <20261008141501.2182964-1-ian.forbes@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

LGTM

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

