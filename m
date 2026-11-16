Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD3606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=B1SPhXFU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E1910F47E;
	Mon, 16 Nov 2026 21:40:13 +0000 (UTC)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E817710E466
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:39:59 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3b3a914e4c8so329383a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865199; x=1795469999;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=xS8WaSxJDfBuTPRUy3hkAviWpE1DMNfZKBX0B2TCWtolR2HzIoL1kYG1DUh7UymHKe
 h1QDAl/Ity4tMwHLxWSZf1+Aga/WAd8ei7qrNznsDlZt0ookWhgGlpg3mbxX2sZdqwM/
 tDMicioc2uAPhtEaQc0aF9eazoRNhtUjHibAbqg7owjfth9gPHr9lsWBG6Jv75KfcsE6
 X3qneSccc3gHtBERI2cF6FXdozKWDA0P7i8KaeybuaBuTShWjiS9aN8v2F/ec3oj9l4I
 VNAO8xoPZ97JCfizq2QgdCKzwzYhvwqVqnr1szDwMIikZrBygsPWm4IzduM59O8PuUMZ
 wUQQ==
X-Gm-Message-State: APuU4Z8HuLvSUfzs1nm8LvHQV254QKK7MVsuMhVQDm2Yxgz+M6DXgwiu
 yQV/T/xP2gyrJcCTYSRDLQJANchMnxy+l3PrARZKgavotUUdlwWndcVuES4e0h9F3f8iqzejj6L
 ykbtsUQn3MH2CMCnm7dJn0n9BlUOGiMM6/18pdpaJ1FpOkPWgtdHySXOxF2Ds5F+e0uJ/XqnU76
 CyLkXIbL5vLvSUG7gNKHWHNnPni5b9oasuxm0YI0WqW/EFSNFUFs1ea4cXRbUro8fbF7XlLpJO+
 N6lZo3UOVx8J/kO7sBr
X-Gm-Gg: AZFdTZfthyVTs2+k2mYs/JWxUDCc2aMUuPs1C9hJ3ryru7AhgxR3R4WiM+/ESUTzvez
 nqMffYQbdvduaVZT//ueBmQyGMuiyo38VVyo5GrN81RpL821d9j9XndxzVMMF1lzhWfTMz6d5jE
 3rRA77teKEOiYGgSZAJZMB7jp75GCpq+zhZpE+BKaaEpJuGMlf2g6C7I4CSEzWHPkEgDa4zTtBa
 3md4wkyhrgm+uC/8GsxF+EE45u7/vvPLJEH8wMMHHXcNZBOep20s8uVgPRmzALiE1StKFHF2G8j
 zoeinoEzPFwdaboAX3rZA2Js/nM8nygF5tSwiBiqivEAyFPyly4RHyAaZ1p/jbQoyKRx0ompK54
 9kl+E5w3TrEQFIB6e5/K1aBhKawAV17Kgr7dxEs/HYWKNLozJvS0lFK2G2lpnfoA7BcYZ7upjj6
 DFkYhD861Wr/f9wBAZAB2t/rAqBjcrnsyf
X-Received: by 2002:a17:90b:4d0b:b0:3a2:b16d:928b with SMTP id
 98e67ed59e1d1-3b1b0a48f95mr10681488a91.46.1794865199332; 
 Mon, 16 Nov 2026 13:39:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3abceb007sm420082a91.4.2026.11.16.13.39.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:39:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b3a348a6dbso3445172c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794865198; x=1795469998;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=B1SPhXFU8g6Rnc3SPwX7YGX/zfwFHrTEaIP/6+h7nnQzLCryUYEQrXKgHBANvWXe8x
 vZVbCarPrljCcEcsA7P8wZvgILl6X2E9olDlCNdY1i91om9u2yUtxYEwVcwIk2OCR47W
 p5mMjSGqYpop2f1jgsNX9A3XGqrCsclLM5A8w=
X-Received: by 2002:a05:701b:4281:20b0:1b3:af3a:e784 with SMTP id
 a92af1059eb24-1b5031570f9mr12230335c88.32.1794865197370; 
 Mon, 16 Nov 2026 13:39:57 -0800 (PST)
X-Received: by 2002:a05:701b:4281:20b0:1b3:af3a:e784 with SMTP id
 a92af1059eb24-1b5031570f9mr12230172c88.32.1794865191949; 
 Mon, 16 Nov 2026 13:39:51 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5329ec87bsm8162390c88.0.2026.11.16.13.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:39:51 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 maaz.mombasawala@broadcom.com, michael.banack@broadcom.com
Subject: Re: [PATCH] drm/vmwgfx: Never destroy STDU zero's Screen Target
Date: Mon, 16 Nov 2026 16:39:48 -0500
Message-ID: <179485275606.3430538.17052063469507523535@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514153103.1465013-1-ian.forbes@broadcom.com>
References: <20260514153103.1465013-1-ian.forbes@broadcom.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you. Applied to drm-misc-fixes.

z
