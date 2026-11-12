Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E2606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KOtwYOZQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AFA10E092;
	Thu, 12 Nov 2026 18:37:50 +0000 (UTC)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F9E10E092
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 18:37:43 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3b155f50c24so55412a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794508663; x=1795113463;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=1M2c89apz2X5LbP3n39mgtKe0LrqkXviSPqlQ/xN2v/UqNsSrGox4BjGbQHFPm8V7S
 Z/ELmXXQia2dxiFnt55kaLvppRLN07KyQkOQNagbH0rF6/AlY37pWX2LttQ1jewyG7Ln
 /dBdEqVZ1G1Q9tFryAhWGgV1lECoJRT/buYeNhrcKfDv1nr9Sz1nt9CJSjZooGWUBBoz
 nN0MwctfC4kNkMWD7gVzbcpndjGuRMw746tOOejR3NUmBhcsKLr1qE68RQ+WChjy8van
 dlbF00whdFCOPmUO8iHbouEFLKKJ6Fr0YPpkVEe0UXrUjSL+ujIQ8Jnv6StKhnB7PDyN
 FfQA==
X-Forwarded-Encrypted: i=1;
 AL+hErGjVHHsLjZspAPLr+KvrjaK3dUgQW22mPIlipViipF5z5ucT+VkKkU+f14oeAhPLlJmNyQ73uk/3cY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8tX+G2qWY+TpOOLwOJjJoQScWOxk6hfgtdSfY60DepnW4qp0kq
 nlBiweFoIVBvdhzpAvywFyOa2YdKUuqmpMmWd2RmoAMi/oOGqvbBa1y4ZTyr5BUD0STSwHRnt2j
 4yWbOlB1P+gAa1Bv9deOd1E6z5do7DGYVXxXks4HjRWxaBY9uqQIdyRaiSOb28egefy6zBg38Sm
 qMeREtbstzuPX6T66d7q0D+Zzf8K3HJJsPKp7VYlH8jXG/RukgWTvTwl5xaPaSkMmRCxbfK3weI
 XTMogVD/BYJM4a7Sk9HfmlGzzfI
X-Gm-Gg: AYBFou0blGNY+7rbKsyVossdGV7xOkXBi0/cA9fx1Oua85pxs/YpjvhFmbISnxEpA3R
 DP9pqnOws0dxB11EOLl1a3wRzOyqx9i+Wb4UbpQsJOhPAP2Z7GUQkJq63b5VzskASQSJw3YCLoh
 iFA8Wzcd749nHyeS3Tuh3g08sS0QU9QayTrRh2S8E7Z5Y6t0CAxSWgBvzEWXKnrBSRJUpQt7Gvw
 WVCBnW94+buGNCs2xrExmTRZjkxLvLtgasV7nnNsnLm3w/9M7cFs7AR2I8BArQMHyjWuxA0a6pg
 TL1zzCQ2tNIgAzQaTtw35dgcpAkNe92uympQ46fvKfLBZVbV+/LfdHZUjQuBTCY75icWugJXubE
 0YuuatvnsN/y8YFC/xyq9+W1xYZ5oLgezVXHOh0v6SGEDwJdqjQzRixqpVL+460TKEZJEnOsu75
 04uxu6TT4ClcQHgdBmdoJNpe7L85l4W/Z0hgbfgGWF
X-Received: by 2002:a17:90b:1d0b:b0:3b0:cc6f:1046 with SMTP id
 98e67ed59e1d1-3b182f91db4mr6225309a91.67.1794508663129; 
 Thu, 12 Nov 2026 10:37:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b197c1a3e7sm3169303a91.2.2026.11.12.10.37.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Nov 2026 10:37:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-370230d93efso482898eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794508661; x=1795113461;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=KOtwYOZQm4fyRZu5LNC7pRh54FO8plN1bM5gzbwJDYToIJVPciZQeRQJLcidgwkO8h
 N4mq4T4siWZjnnBzYfnvvw5TnAR3lood8plXMJOGSK+Q8jFecHB5fHiQ3rQvFA4PfEoI
 3tk4QJ4ujnW/la6P7pH0zWYTbWKEVmCFs+KXQ=
X-Forwarded-Encrypted: i=1;
 AL+hErF1NyLHRlr1is/I8aKTXEj8GBTq5Ez6EfQ7ETTrllRYcXGzapG+QEEu6qfWKmVH12HJTQdHz2vitC8=@lists.freedesktop.org
X-Received: by 2002:a05:7301:52c5:b0:36c:a281:1bc with SMTP id
 5a478bee46e88-37966a5ba74mr13301eec.16.1794508660978; 
 Thu, 12 Nov 2026 10:37:40 -0800 (PST)
X-Received: by 2002:a05:7301:52c5:b0:36c:a281:1bc with SMTP id
 5a478bee46e88-37966a5ba74mr13272eec.16.1794508660356; 
 Thu, 12 Nov 2026 10:37:40 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379558231eesm353962eec.12.2026.11.12.10.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 10:37:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 10:38:59 -0800
Message-Id: <DMTG9A5MNXGM.3V2N3BM23YGMF@broadcom.com>
Cc: <ian.forbes@broadcom.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: validate command body sizes before parsing
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261111193836.3161904-1-zack.rusin@broadcom.com>
In-Reply-To: <20261111193836.3161904-1-zack.rusin@broadcom.com>
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

