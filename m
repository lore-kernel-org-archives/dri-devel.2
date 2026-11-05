Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F1606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KvUGRpQF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC66C10E912;
	Thu,  5 Nov 2026 02:39:43 +0000 (UTC)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D0AD10E919
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:39:37 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3ac6794fe45so1102351a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793846377; x=1794451177;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=hajNJyoTJHHgEeRpTbVVWM02phEDlhptOyrXzEneb9EsAIJjJKjSZCuVklqY0Eqmy5
 fIahP+jtdyyRtXOB8CR74Lb1C4Eq90BNmPpXVXi8xXrf0DZMdaCuww6eXS/5MRT4QNjv
 Pzo95xRtoRbt5PQq5Sk++absxJJMvAQz2YiQGFQVOmSlGo5RBN8o3ks7Jp6q45NDa3QW
 E5M0ACN0VExJMn618N4erEr1pR1yWA5VW76+Ainld6PoZp/zlVAb1ruWUq2lQ4UZtcFD
 U5e3df0VpdTMTiQnxjUG+KUWPBQt6QgiE7gtOSad43SoqgDEUFBF/JuARRzV3hnWOfGh
 58kQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBym4v8+Sytuv2rpoxQyjbInTcttltjX0W98XKKJTPZy3PFZvFDyv9q47ibJMvVmigKe4dUnUOm36GA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dPwht4iQf0baJi4Z9FY4wYQ8JGnTM5FcsIp9TmdtopUCYdQhI
 5x1qbpkIOZR+aQtVWJmtwTi+hm5j5iJyQYawiHqXczrIBkHT1Edtgp92lMR+30KxHYVnSWcNvBy
 j1QjSpl4q01ufzukJKPFQn3da0vSbwiXSJC2C+49llsYstm7CIQYcEAJjg+OjsH92FHVSF7Z8cg
 vEcLtWEn5/FKwr2Z44YdAezaJlaFKSDa+jVZsa8ES8E6gmm1VhSczhLa1UvbRoWQifPV0hu60ES
 7XN9JDjuWEUU21PZXaYaWNE6v6m
X-Gm-Gg: AYBFou0X0eDextMAfvEi5xs4IVMHTqXhv7ibE5P2N6kTCg0N0swK5Eb3AAAjFNswBop
 bRnG+hq09JC41HhkB071ycHACw0QSMMIgWrl4AoYh0n8eLjijuMopd5EHu7HjptSkGfn57LtkCu
 xzPIPngwTjbnMbug5iaulZNn0SMh0K0DzaYu1YLZr/shRqBVy+BsKm40/0BJ4hYYsJp1/5Rb0gX
 PYlfUJKTjF2qsZ27ADFRAvReCvTDqrI/sY+SeFFQcN/noBk/qagy2yZNNCaCsaMPN8zDJaknXDY
 YfPo7itsB/kbqR77SF1iWkn1GyqA4NGbuFhKzuzJD1CCniI3UffgSRHrtvJnbsnVD6RAVTMo4q1
 fZPf7w/osFTCVEQbda8QU9wrEWRAPmwrxAcI0INc1RNCv7/m3b30Gh9n937s44CBej5X5gUL42m
 5N0Qi5PfyZ5nDYZvlSiyiK8d2XlsdjVtbjuYA72H4n
X-Received: by 2002:a17:90b:4b90:b0:3a4:7730:33dd with SMTP id
 98e67ed59e1d1-3ae8984b662mr15282814a91.58.1793846376981; 
 Wed, 04 Nov 2026 18:39:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b0b327b8b5sm877623a91.6.2026.11.04.18.39.36
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:39:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3662e7a9299so4796234eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793846375; x=1794451175;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=KvUGRpQF6XDewb03RJHW3b9vqTwWJF/lKS2Ast+gR/aamrnGq5HAJ2E7BHHlukLdHv
 elgH5ieTpzAj+AxVydUXGjeFeecAw/2TmeNnSB80nH73rTfSijlNKx+8+crMssP8wKSD
 qWZLhkxELFTJVD9d1pSfEViRRS2VBDZkI5q6M=
X-Forwarded-Encrypted: i=1;
 AKwUvByG/cfkKAsrCzESPA155tiR2tILnIQ7uI+YhQZ9W1y8AqhOG4ffairbHzkMt2khS52pBC/MGeAu++A=@lists.freedesktop.org
X-Received: by 2002:a05:693c:41ca:b0:36d:2b50:4eb9 with SMTP id
 5a478bee46e88-36d2b5050femr3978951eec.25.1793846374797; 
 Wed, 04 Nov 2026 18:39:34 -0800 (PST)
X-Received: by 2002:a05:693c:41ca:b0:36d:2b50:4eb9 with SMTP id
 5a478bee46e88-36d2b5050femr3978910eec.25.1793846373963; 
 Wed, 04 Nov 2026 18:39:33 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm4756075eec.10.2026.11.04.18.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:39:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:40:54 -0800
Message-Id: <DMMXHWJXBCKN.1OOHPUSW1BS7A@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 4/6] drm/vmwgfx: reserve dumb buffers while detaching
 their surfaces
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-5-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-5-zack.rusin@broadcom.com>
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

