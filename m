Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE587C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0233D10F019;
	Wed, 23 Sep 2026 13:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="ompi9Yc7";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BA210F019
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:06:14 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-142dce6e237so662099c88.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790168774; x=1790773574; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ih23spaVgrDHOFSey9aqnpQ7LFap1dWio/xJjG+h0zE=;
 b=ompi9Yc7xvWqZRDkixNBUr6gnivRdjXSdzCfuKje+DRcbWLKAI1w2Hl/Ctgm+ERN8C
 hgUDLAp/MN9UAiynt7tnic1XwOOwqnmgnJ5ADCkLB3IV0tbiks4X2PE1JzVxmCt2J9mH
 /Hu775WbV9miopYfCMfCu4pBA/3Q3OW4mS0F1G/qfLEZjq5VArT0adq3QsBRPU+qCTD/
 r3HHvpjuIVt6jePky8d8eP0xGPxCWH5x9ihPeM9w0yVL72fCz88CUt3IwSeuCjOlcjnp
 +2iYFeNCuYL748eQWcdjvo9Bgv9YC69aEzUnku9hu8xRXYbibkqVsynjj38WUYPeyh6l
 17aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790168774; x=1790773574;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ih23spaVgrDHOFSey9aqnpQ7LFap1dWio/xJjG+h0zE=;
 b=kyWRHP3WuZp+WSHB0BU2BTDz5aSxWzl3G+wD33tU7d4KPz+wc/OyxC0QTlN/2uSKGh
 28usnLxMqqq535IAufLdAX5SIybn5ucQzpE5cUiyaotnGZX0+lUTTCQT8Vfa4owDK0J5
 jsDEujjhrGsZ2kyKP4ywVKiA+s+fv7cSyYEJgMJSSEBXyikmh5NMMh7+Ry9oOVxWSdKa
 8b+F2cE+IXOqH9lYW1BB4ZbH+epPy8wVfxkD1PGPz1gyaUKKBK1uI1vjTmKcaEua7vKE
 64sgf36YUUKqc16RQAY3tl0and2vk/Pz7qCoMNtgGjpQrHO4G2+ifILjA4DB8oTIdtVS
 sJxA==
X-Forwarded-Encrypted: i=1;
 AKwUvByXGl0NOKXEEO/3UAqXQdGE71ccem0AnNvLnQt0nHJSq5dHdB4ffg1I7clx7CnhYajKhQcShYcoJxY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mOFNCDENLXWixgOmHYvVA75cJnOFm5WAIOdUXFX6Kttf2bncnG
 HD4cTIAy/7T2VDmkrpG2ntzfgS0zl1T8XGLcAjRtEOSyWQQAqQNq6pXIR/Z1uVPb+nk=
X-Gm-Gg: AYBFou2s/lrGm9eELGJpikbkixkkJwVVhD3e1oNEO1YIWgQVw7BNw/Kq4AKbT2oYXTN
 6GBkUDk0tiGD7n36PL0gJsMnNLZ2eG946lrCPuFxXXnWkTWHBTWhVyUIFqCQybCjsYrFnHNoiN/
 OvW5jw+FOXTWfk5kLNGCfUK4DMug+w/ZHIJ/oAK8Q9ssi2yu0ixxZsgrGcGPVX559OFKUZg57YL
 EEZX8Xo7R3f5NM/VoyWjceiQWKKaqFczpI2eO7+BOEM+xn2DWv9z1wic2tNd7BbKVOcjq/DGft6
 Zz2wpqA3xL7XqMiMzhimyz5dxxVBJM27SiRtNCSwP6PQTmiibhwSfD0JiSoeiUURdZaCjjA0MkK
 f9lFFGXWm1JqAbuYudXKlkVqgSpjXl5xNny0K8/hN1YfBcTX445+uS0O2RexGm/gVVKzHkYLmWQ
 bqL745lvaerrfxoLGvGgHxPTJYGf1ACb05bFc6wZlhqNV1
X-Received: by 2002:a05:7022:1402:b0:143:2719:566c with SMTP id
 a92af1059eb24-144f9198b49mr2872815c88.40.1790168773123; 
 Wed, 23 Sep 2026 06:06:13 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm10833873c88.13.2026.09.23.06.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:06:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x9Mfr-0000000DZ6d-2NEP;
 Wed, 23 Sep 2026 10:06:11 -0300
Date: Wed, 23 Sep 2026 10:06:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 christian.koenig@amd.com, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <20260923130611.GF1540250@ziepe.ca>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com> <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com> <yq5a5wzw2ree.fsf@kernel.org>
 <arOspFxWZ1DjgcAr@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOspFxWZ1DjgcAr@arm.com>
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

On Wed, Sep 23, 2026 at 11:40:36AM +0100, Catalin Marinas wrote:

> The simplest is probably to always zero in the backend and ignore
> __GFP_ZERO to the allocator. But it's probably only marginally smaller
> than passing a CC_SHARED_ZERO flag down. Get codex to try this as well
> and compare the diffstat.

For patch ordering I would convert to use the allocator first

The semantics of the new API should be clear

If you pass GFP_ZERO then the resulting allocated memory is zero

Otherwise the allocator does Whatever The Arch Needs to not leak
private data out.

Once places are converted to the allocator lets go see what is left
and ask why it is left and what API it actually needs.

I think HCH was right that nobody should be calling this in driver
code, lets aim to unexport set_memory_decrypted as an ideal goal

Jason
