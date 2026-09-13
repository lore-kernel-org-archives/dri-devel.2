Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE09C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF55A10EA07;
	Sun, 13 Sep 2026 20:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IbAK6XQV";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3271D10E0B9
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 18:38:11 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so487014a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789324691; x=1789929491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f8egR4dMbs0feNIgyGf2N4bg3BFUD4E92PNKo+p8ClY=;
 b=IbAK6XQVf6NoXwHF1P7CCh7FogQrYRTTHF+1LBIBJjWcPakgVlwieCs7gm23G9urKB
 P0s5gpYyu24SPoWUIVK5Uf3p4ZC+UZGPWbOa+U4GXJpjzVMAcq5HLINv+XodHfySU6Hw
 vc/jB2cxyIwbt/yAujahNiUjxZL/+Mh0X9p9Nl/M2ZbAUPgFUU5fqtgqs+aIB/sF632j
 CwyYQDIaYfl3R5mfjgWYCiaxAJTo3Rz+LEHUyhohOSCmz6fltZtE3XYWKazrft5Jk6Gt
 H2XOIOfxS2fGoCtH/PwQT4RZVozP298kJXoj6XfQPA4gjI1rS+N+lH71XJR/x6kRoXr/
 CXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789324691; x=1789929491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f8egR4dMbs0feNIgyGf2N4bg3BFUD4E92PNKo+p8ClY=;
 b=S7x6Xo3MHvI9cUBKtJBu3/dResx9MhmXnscNo3QtU8TFxD1jykhT8OJJ236wG07b8t
 0tfcAX/C/4+1pszxE5l/DFG8WbpDer6oI2t7UlMzAn7JHgJWNw1ulmBKQZPxFC42IaDl
 /P8shKWSTN3dFwqdHfG9IUCRfsvUwmIQ52qYtwDKjUxWYTRmCWN88unMLQV78hf3jHXZ
 bkpk7nqIjN3NBlfFFp2LS+R6CaGpATTcWICYxHpAQ9fzUEzZCUJVI5ot4sLKUQc+zron
 eCNjrzdYXxUMJux5S5K7XSdY2tWKSThaj/6HYJ8qhwDiVj4VqbbESSfgeHpI4dkpbho5
 QdwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQR/g5WsRh825FHv7l0y62/8Fl9xL9phzwe4lvfcUhszmVCEQ1iO6ZOudNEGgcZNNmRRTuN+2NSNU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m72XXs448pMdf5V9Wo9bFP6qrlqZp4mCaI2nWrje0TCLdT8gWP
 6UJqfXXOFnZat6FWxsxlUY7jBxvJxpqCaxwac9jV0So4QaOvQM1fnxHT
X-Gm-Gg: AYBFou0BrTtt0H42684RIhc4VdFt0oybI8HTRI4V0lJtuxP+W/+bSO0ECfd/6NU5omh
 d09P63ZbvaEKR0ih3XlUUArC5UaCZjMzehAeN9lE/Q5aLr9nkMbyrWr/4fF9fPy8yzACwHN2jXt
 s/Ur9mVoCSLpF2Pbwik7Dk5t2cJIZ2371qhauPJtT/iPOsxTEHeiJCQi/pJIe5Q4fNYPtCnZyji
 OtQVca3Eh1YxbrNxAXB7EtjLfO0NXWlWda0pqkoh8lYmnJX8MQ655PZbT6z6dYWwXMJpRtAyh3u
 VL8xc2tbW0FodhWnzzp9TbS5iUfrCMRIjZZ01OG4KxDmKzoDNAMkzl+xgtJAv6fQTI3EWDCfRRC
 Aq/Ns28SQE8qfirWo7PlnGsgS6Z/zd8v+pmAfudoLtQa5QE72Pwx/L577J8BfAqgFTSzpstYb7X
 C/+d4Oc6R/xP1YAdp/5WRkJzRFtpLu43mktZaAoh0JSy2t0YJk2guboVeDsY7Ln9U+b2NCYRner
 osMU5P+maJ6Ai8gQw==
X-Received: by 2002:a17:90b:50cf:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-39dd54d7dd3mr3783446a91.2.1789324690644; 
 Sun, 13 Sep 2026 11:38:10 -0700 (PDT)
Received: from localhost ([95.190.112.239]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d9b08165fsm4118447a91.1.2026.09.13.11.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 11:38:10 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v4 3/3] Documentation: nova: remove completed GSP log buffer
 task
Date: Mon, 14 Sep 2026 01:37:34 +0700
Message-ID: <20260913183734.134307-4-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913183734.134307-1-vladazaharova2018@gmail.com>
References: <20260913183734.134307-1-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Exposing the GSP-RM log buffers through debugfs is implemented, and with
the gsp_keep_logs module parameter they now also survive a failed probe,
which was the part of the task that was still missing.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index a01c362b1be0..28fc7329d56b 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -141,18 +141,6 @@ Implement support for instmem (bar2) used to store page tables.
 GPU System Processor (GSP)
 ==========================
 
-Export GSP log buffers
-----------------------
-
-Recent patches from Timur Tabi [1] added support to expose GSP-RM log buffers
-(even after failure to probe the driver) through debugfs.
-
-This is also an interesting feature for nova-core, especially in the early days.
-
-| Link: https://lore.kernel.org/nouveau/20241030202952.694055-2-ttabi@nvidia.com/ [1]
-| Reference: Debugfs abstractions
-| Complexity: Intermediate
-
 GSP firmware abstraction
 ------------------------
 
-- 
2.55.0

