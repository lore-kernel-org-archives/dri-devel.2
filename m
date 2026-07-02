Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E21C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5CB10F669;
	Fri,  3 Jul 2026 07:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ASrJMy1P";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D2B10F58F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 19:48:45 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2caa0551d8bso2437805ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783021725; x=1783626525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68hLmhb2rJT6HC8MF+9I9bjhr7Jl54P+QNhqjh8bKmw=;
 b=ASrJMy1P7XOgl9qrEGeBSCZqd3v/LmpovEkiMTk08pAtDMt7EmZHxYGowtaMsxAy+M
 pomP2poBnkRnvNRZ0uhN4WcnzX6ceg7yTTjutu6RapC35xdPsdnqiziih7CpMFmy8Jl/
 XSsgCRLiQMZuHWz4z0X3ssSYjLqZkdtE66r4cCBAApjclKjx5oLr2s7WHAaFIIpHE7vu
 UhE4lw4d9msD0fl93cePz1RTqhlx48GNS+0ijM1osiIp34/4/rrSctAyILcKZvNuN8U/
 l8QVlJC/20AVvS5ID3itDf6pl0gU1ppesJwjoTxXLUnwpyFxzRk/+mrKnxmjO3y6tiaZ
 yGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783021725; x=1783626525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=68hLmhb2rJT6HC8MF+9I9bjhr7Jl54P+QNhqjh8bKmw=;
 b=SoJZBgQaXCSRuizaAXf5Yu6aPlcMtuUGJfPt61R89U+22HrYPV0GhTBH+gZwjWMjJM
 pBp6eeYzAl4Bxc3aKR6PcnLl+bnEAUDaTHoZCI6uymjN27FNZnceFW5bQsEG7/CrZ5rx
 ZR6ZLOuvaFbFze85mU2Grrqqftc2qiDBFqig3jq5daPEDriufcRxujSb8UO0OrBfcPmQ
 IvtOYs+9TYF7AaIUhI/uzl5bU3TF4vdoUoJ0nDFfsSydrDW5yhfpQJP4fhtBVfvZ/HU0
 U/VHemD+4Y65QCd9G4TuMts/ex1FzsRl4uatORY916KutCN5AJnK+FAxz49f+3eGO1RD
 3UbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrag2OikZLYhFdSOEmw6YU+afgJJpQvTi06TtDgooklzq6jbWWIGyBIsXuLhQrj31wv+XTR7OW8HcY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxURVGi5HcXI+q1D80anhTqwYgBop7vp9bAHi7ViF/FmDqEpBs6
 02XL9iW2CRkcAHoiAZaXvETNLwhwBWtL6pwMerIAlCrOEwgNfuw0nSVs
X-Gm-Gg: AfdE7cknYe8WouunZKIYbfaXTN1wcsqZEpetvVcRj7e/iNjmo50MWdbDEAZzbsGJuPJ
 dfoN85CZDw4e4zqx9io2UJbz8HmBL3xTp3wIMtyYCa+y5/Hi6St2GhME8+XmSJYsgOuvnLdP1lj
 /JcClBoft8hd1YWAZbMmZWFLtM2Cfmt/+nKOrhjnbiej5LS3omlzyctH1IKFz4grGtOeZb0zr0R
 pkH63x7WyojK4HjtEeh28w6Ro90BgYM4EAdn3hT6jpPAt1x7/gi+gHQQ2O2wONXr6leaesb71bI
 0EN0quN6Qve4JcG7bWOPSzAGoogZ7RuQ7cN9rIjKrEjY516SnCu1BKPJ7SQprdGRaU2RrHpy9nb
 um3Onc6cocInyzXPXrbU6oujNKbcN5PvOwlqJ6yOnEtdAcQ3xNAB7yruK22uok75HcUdZVAyHBL
 kzxHkh/psn1QQwDFm3N1P/PGc+iIGbKefSDaw/eTwZYqAK3yQzqm5IGjiQJ4E5zhfVtuNOUc46p
 D1pYjE1v6nfE36lqju7oWz5u8egqY5MmH9BuoVjTpb0h5lm+rIrC978Qn6Ma9p2WP/r1R3cxyds
 e1iRO0cEyD72PNdJ9Tx4Jrrdr2nCqVGACVoPoA==
X-Received: by 2002:a17:902:d490:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2ca7e8cf2e3mr46822875ad.4.1783021725266; 
 Thu, 02 Jul 2026 12:48:45 -0700 (PDT)
Received: from midnightair ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7ef5b3sm16339527c88.1.2026.07.02.12.48.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jul 2026 12:48:44 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Peichen Huang <PeiChen.Huang@amd.com>, Chen Ni <nichen@iscas.ac.cn>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Anas Khan <anxkhn28@gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate link_dp_panel_replay.h
 include
Date: Fri,  3 Jul 2026 01:18:38 +0530
Message-ID: <20260702194838.66361-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702112828.34698-1-anxkhn28@gmail.com>
References: <20260702112828.34698-1-anxkhn28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

Please disregard this patch. I did not notice that Chen Ni had already
posted the identical change back in February:

  https://lore.kernel.org/all/20260211021953.2504249-1-nichen@iscas.ac.cn/

Sorry for the duplicate.

Thanks,
Anas
