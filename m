Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E879606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hTVWcUHs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651D910E68C;
	Fri, 30 Oct 2026 00:56:03 +0000 (UTC)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C7210E68C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 00:55:56 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2e987b4a710so7526165ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793321756; x=1793926556;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=bYCbZVmX3pyhtyifyJtUECXKPgvtLm96m5G7ZSahuYhl+80s4Otn8SC9hWNo9PSjoK
 yxKcft5IUONiDy38JDDzEDigAqjblEeYIzzlLXZO4Vn0awpbf0ymMCNXQf+ukmfyG65G
 htWFeyavvGslkuq2EmL+9SA5kuRAhPX/gjVxV4cr0mpg6e0u7NoSqPcyquSvBFhV5Maz
 YUoEw37S9xgwUwYrR7gVH+aapeEkUiBybxID4pa24gxSVHLe2rJ/nvrkci79h36/oaSW
 gTRaOX/NMdOzLM3w/Hw2x6+O3Z30A2LULsQfeRAsdEsrS0DoMK3fEleqoHnhl+IF/wJW
 1iIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb5zwTlg1H2G7AP/Xfo0YBBzfMEYs7Brck4ZFWePTE3gTPA3B3Y9Q6rm/bmDMMNrW7CMuRUOOmPbM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKot24AfY685WMc8Sm2EI36krjzNBwu06gNxxea56wi71MHe6re
 icAbN7FQ5w14rLF6xcr2nwP+Kay/xtXnVTNJVRZe70+j+u6AXKzBsR/4Cw9ClX+5R/N2ByJkDxA
 vkDhE7AmglEXE/ehY7Rt5EHzF5+DWkTVpd98aCCqqJEkwZixhM41JNVutYPZXnKYTsrkgiSukSu
 4E/9C1GcPia/eeCQ3Pje4wdfPA/5QJRd0zKMGgZNIR590zeYccwLUwznjRt6oe0MTZcJTOHvqFT
 Q2ZqMzKhIjdKCFXMmDD7/rlig5n
X-Gm-Gg: AYBFou0bUSrL/+7nN6JFHYW2CCF9G3QcNnYTmi72PB1u0r3EqPAQKeODHDbicPSq6dv
 kwvgU4EVyTVMXS/7xvZkkaee5Y0jMaVxqL8nOASWbB4jkSO8Iajb6NHgJHBPRA/hieLx3v15H8k
 dIyp6PurU4c20aK744m/f/hN83csXZxzxB2MouIZAg4cwj1DpfnIpcl4DhGBYcC2ySnm8UGV+8J
 jWPa3DqULHSSUIy4wsnHGe1A30w8+oxAuUVgWAfCSeDIvX900OYkmWWMSGtn38aLTvffOMmxOUw
 GocOGV1E/6As6KLngBNEGKtsR03xQaZgoWjdxdb4H0UNldi/0qMTa0fpvKOwr04jOfPh58MEOys
 JkAfkMOz38YNpyVtC0TEeli4nHzo5KKJUmhizPBoOeXUJoAwndy8SbCC5AhpzU5Kprfo5vezxhG
 2trZsvdEMyvGlhBCD3lUx0WRnYKo0GsmJpPXJDzpQN
X-Received: by 2002:a17:90b:1cc5:b0:3ae:3d82:5d88 with SMTP id
 98e67ed59e1d1-3ae8917bf84mr388141a91.0.1793321755581; 
 Thu, 29 Oct 2026 17:55:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae6e874b16sm3095018a91.6.2026.10.29.17.55.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:55:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3698bd5392cso200831eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793321754; x=1793926554;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=hTVWcUHso/qL0S1KwioCg+I4QYgekz+XlKzyYKHv4ER0hMrPqePxi2RzkiXZ+IpfdH
 1m81bWvOr8YEPhXeemaIyA2vLZL/VPWupX63LakSfUyWjh88Kkp/TgoVEdBrjrCRIWG3
 jp1O2FZMF7VXsT0h+e/3R4eUYhDR5oDlH7VEg=
X-Forwarded-Encrypted: i=1;
 AKwUvBzoi6kyUN0tXZqk8mO3Eqhtw5cnIEiG9axOkDkt/lY7FDeAars83llfWFIxAhameaYpoNYEynpn5qA=@lists.freedesktop.org
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id
 a92af1059eb24-1a93c6ccfa7mr5041513c88.0.1793321754044; 
 Thu, 29 Oct 2026 17:55:54 -0700 (PDT)
X-Received: by 2002:a05:701b:2511:b0:182:d0a8:d1a9 with SMTP id
 a92af1059eb24-1a93c6ccfa7mr5041486c88.0.1793321753424; 
 Thu, 29 Oct 2026 17:55:53 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6eabbsm2198320eec.24.2026.10.29.17.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:55:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 17:57:14 -0700
Message-Id: <DMHRJ9K73XAV.2Z5TV83Y9TJRL@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/vmwgfx: bound MKSSTAT lengths before rounding
 to pages
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215738.3010276-1-zack.rusin@broadcom.com>
 <20261029215738.3010276-2-zack.rusin@broadcom.com>
In-Reply-To: <20261029215738.3010276-2-zack.rusin@broadcom.com>
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

