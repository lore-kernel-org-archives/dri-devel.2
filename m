Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9695CCF2C4
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3988E10E39C;
	Fri, 16 Oct 2026 20:27:17 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9281610E39C
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:27:10 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso3722525e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792182429; x=1792787229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jqtp5LPxF0IFxOJfCVzAQN6SnoPJKqsXWwttpYr3O58=;
 b=KZ/WnmGFPJgsK3sN5vOQr3YmcN5hNEmBzFj32QVjQC0URelqFGR0h12S8P/6524uig
 hUm8HxtJ+wxBpdUmUEtvXoouJAUV0QSCmf+2KF1NKofSY9OUwunjx5V6C3eRMVPMDzv/
 q+genrQVQoehS36dJKrddLR3GvE8dbUHXA2xQOOoijuiitAr4OIa9TiWv1tShqOzRb1u
 xB59UiuWpRztf5cPPQ2OYA+VOmQVY0ZVAtUPexVrrEPdgz5M4hMRb2T6HlQHjS9wv70c
 Nb7YtDmdzWCqf4OpbjTCJn4xfNqiJesc+HMFDbYdaRMJVCD/XLLvR91uKEWNn2NTtZ8T
 B1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182429; x=1792787229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jqtp5LPxF0IFxOJfCVzAQN6SnoPJKqsXWwttpYr3O58=;
 b=PFBIGn4hqIwSj25Q1Uw5vtplMzhWcGS+2mhkfzeXY2ZyW+HkHuAMrWq8wP7oNKvGjM
 OneV3XpSUicRcqt8zFhuDBfib+05DTAMHm49YQeINkDyr/+OSMsf3Xw3Snfv1NIQxmNu
 fgSGaP6oGJHXGhEI+S8BRvWHgjCWGnog6EXbWRet19bpqG8WbUonxilHjznDwA6OTAq6
 X2MKxgjoeI/rA7d3XMCrxZG38aVu8n1v/r09wDrtEOBVmtVmBDmSMepcu+/QLmr2Em09
 R8nMoH5XglEjWubfhs/Dv6rdR17KCrdlGvQNZVHDeHdUY3xmk976WF6Sp8rvdjgJvDIp
 4fTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx8h44hoW+i/xRKxSI4gSuPOaoBrsfh57CnU69APQMXoxDM3PyxAVAKsHur5fQ85Hl7YtJ95g3VRc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLYc03U5m58vmJYb1A7nOjZF1z4Pedsyltj67/Tmnu3+re4e0Am
 W6UE6tgAS3bvYfvdqI+O+MPiZl7ObCcuj86OYs5cx4mm4CbQwfOF8nG5
X-Gm-Gg: AYBFou0a0XEbZ6gvvg7ccau6Bco2jf09GKYRg6t/c8YKKTHBcwhv19gt4kmhXtQi27N
 VKZvZXmf0Z3Rt259T8/6WQA01fCZAkzNaiwjgSpC4Lr2X6lGjhMEKWmpJMULjWuH+S+aWtI1ijY
 clQ1CrrQkRjCUXDhwl6rEJEX6EKfQBU26PdAuCcw85UVFFsVNr06jziO3ERRbbx8exUrE8v1Nss
 tTGtacIfUVYNsThWdjPkMhErQkhOg8FRqkl3LQNuqCkPGIaw7aP9rxnzvno3ZsBVB/becwlaCmy
 8NcGWbRGRG0153uKj9Uqkp42BDs+g2manrkbSSy29pUHNUnLk6LKLGHDyrGJoGrz3nYb6pDdlJ0
 0HceIqlr3tDxJzm7kzSTUSEV9KrOrF0nYQGwpSthydMIvcxjNvg08d1jLFNWy0dPj4wf2ijqsSV
 hdaMmG1llsAdOdksPbK98+YfzmuYs/DtpiRYP3jKFNYBxVB/wTdobxjRENWlnlz9BFW6D5K+Olc
 5WP5f1XpKnjQFSUlbzlGFxV3kJx29X2QUVsGmDY2kpvedjLR8YjchwXXdwszDo+IH2XJQUqvFjr
 bTJCCQydEzHwAZUmSumLM8RWqJ3gL2c3utQb320RoU8atM/Egg1JsgMcSrUoVS61Q8RIw1oWq/V
 bHw==
X-Received: by 2002:a05:600c:1393:b0:4a1:d248:25b5 with SMTP id
 5b1f17b1804b1-4a1d760e327mr19553895e9.24.1792182428699; 
 Fri, 16 Oct 2026 13:27:08 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de.
 [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d7659805sm22421075e9.7.2026.10.16.13.27.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Oct 2026 13:27:08 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Alistair Popple <apopple@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
Date: Fri, 16 Oct 2026 22:26:53 +0200
Message-Id: <20261016202653.97339-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
MIME-Version: 1.0
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

On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe wrote:
> +	match_args.attach = attach;
> +	if (dmabuf->ops->match_mapping) {
> +		ret = dmabuf->ops->match_mapping(&match_args);
> +	}
> +
>  	attach->dmabuf = dmabuf;
>  	attach->importer_ops = importer_ops;
>  	attach->importer_priv = importer_priv;

I may misunderstand the intended contract. match_mapping() runs while the
attachment is still zeroed and without dmabuf->resv held.

Patch 11's amdgpu callback needs importer_ops and importer_priv, so its XGMI
match cannot work here. Patch 12's VFIO callback asserts dmabuf->resv and
reads priv->vdev, which cleanup changes under that lock.

Should the core initialize the attachment and hold dmabuf->resv for
match_mapping(), or should callbacks avoid attachment and lock-protected
state?

Thanks,
Karl
