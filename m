Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DC606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cl461QwG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B9410E911;
	Thu,  5 Nov 2026 02:39:14 +0000 (UTC)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DB110E911
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:39:08 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so1203268a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793846348; x=1794451148;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=scfBpo20vUe+J6KRbdAPBWQ4ZycVmtZK5A9MVBsrvcdUglc1RjhxPuHqQhcvVqgBIX
 bARU1CqsWbidCWVCb2OGKwVkuXCyRlu02CTpUNCBmh/Dj1AsE82Zkf362b6LApulYP0e
 pLoTEe+oXMmCxdb//FMMv0LF82/XCTBDCn00fvbYQC7VeMTBU4/PEtt7TcGDg/5CCbnz
 e/KCI6D2bh8//Q7XeXh48GAmNDq+e7c4nZ1EqBRYKuBkQ5CGlQGgbfscsl0gvAxaab3j
 AnV5RFNocLv84uQPAKX9nFpF6LPcsHlvMKQRgEJCou1qM3iZqDvsSR4fsMi3YUnqIOqL
 D33g==
X-Forwarded-Encrypted: i=1;
 AKwUvBylXvaN7qZlNtU5GzwkTQfB2YyVNBtzEQJZgnK/vM34AIy6MfGSL9lPihRETFOSnQYFcISpDhL/3EM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ZSK6TTuR0Og2LgiS34dVOpen3h7SABOvVCafWAMV9bc6cLSMN
 nysWhc28J3my2X21h1l6zrgQ3dWzblh1KEEXZ08MJcseorG7QSYP5UFzq8h4JO1PYxUJ8HskzGx
 ZJ32VX1mInyOLEm6QstA79IFF7wI6yq75IWCW4PCxAU3tBRn7ryVa9l5IcuM4WvoPo+Ov2FZ/lT
 HYBvwg5SMrriTeEaTdabGbHACSAmiFRL5Wt8dihVih29r8AtOtBTUW7qexU+rSbmErQp8XDEjp4
 cmblrZShXhEATZ8G58n1EAMhr4L
X-Gm-Gg: AYBFou1R83uJLvU/dJSPsM1ryxnOu0MSh1iWtrnyvziSYtJ5YQJrhDNd1iZKCQdLe7V
 qjE3C3XINrLlx6c9IK70mSKmVEZ65PVd93Nklm7a3iD8aTeau/sfUvIuXocowrvk7hjsdYJn2Wp
 9rKDyBx+8k1moeJoz1RQgvwR6BtbsODFBGBiSWfu+SslufqGwAZxfpZPmYblfGKKlRHrpjHqLIE
 Vmyz2QQpRBLIMJWZVjqvneCPjz88XhUjCEQHvN/aAKw+f5j/SG0zeDxvGZiMn9lbfMJz80v7nSi
 ZsvaTyWh8pCBfaLqc44tbWE+Kys+m7EdJDkFyFJ+GacdbwhV555afshUiiXQ3SyQQuuc4G6tBOj
 vqelsKZ3OPVSW0sXvWLVog4k+Qpz/tJXJnQ32UC5OLL+ShFYy6j8cHqCzw2YvBTn28zadjNMEew
 T9KpXYn9xHl7FL2PvxN3Jlcuwgv5x5BBLErNXl5Tmk
X-Received: by 2002:a17:90b:4d85:b0:3b0:a378:1cf with SMTP id
 98e67ed59e1d1-3b0a378049cmr2330338a91.22.1793846347815; 
 Wed, 04 Nov 2026 18:39:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b094d2f3b2sm1398380a91.1.2026.11.04.18.39.07
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:39:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so1566020c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793846346; x=1794451146;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=cl461QwGa2ZWmjLcliTZCRWR7TZns2fXACvOioN1iOFzqp6GMLQtooewPNORB4+P5v
 BQyi5ZZJx1K632MJL4XNFPJVEys0gYBJfVC1t2iT/NvegFgPNM6j3yse218NA9uY5jfN
 Tfvmm3JZ2fvvsdkz5HK/Yj+ZtzmXrd7nwMZE4=
X-Forwarded-Encrypted: i=1;
 AKwUvBxoq/34F3Jn/q/emlKTU/wHc0peVam/5RTyzPjHbhHes2axBSSalNkaA/rd2wxUeqaeXi3+n8QUfdw=@lists.freedesktop.org
X-Received: by 2002:a05:701b:455a:20b0:1b2:42db:8a54 with SMTP id
 a92af1059eb24-1b242db8f29mr8049206c88.23.1793846345894; 
 Wed, 04 Nov 2026 18:39:05 -0800 (PST)
X-Received: by 2002:a05:701b:455a:20b0:1b2:42db:8a54 with SMTP id
 a92af1059eb24-1b242db8f29mr8049166c88.23.1793846344913; 
 Wed, 04 Nov 2026 18:39:04 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b87c4asm11608439c88.3.2026.11.04.18.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:39:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:40:25 -0800
Message-Id: <DMMXHJ7E33NS.3QACG0ZSMROU5@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] drm/vmwgfx: keep cursor mappings and pins with each
 plane state
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-2-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-2-zack.rusin@broadcom.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

