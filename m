Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C052BC531D1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0687410E0D0;
	Thu, 23 Jul 2026 09:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ll5/z95T";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF8810E0D0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:37:53 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so368252b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784799473; x=1785404273; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oPUgpb0frsnp1JVUTki2lmBuU8fGYW5E1pXwN+DTdbc=;
 b=ll5/z95TtL+He8SSZ52g1M/uirnN1qX5XwfEXEwcgxum0D4SIJlr+4qWFTqXjFHSfM
 +PO1HOdV0ro2pdr3k/ZoP/yik1HbSlWB49U8DrTIakiC/e1R6Fn7Dv1kQdU3c5/8dlQf
 pKkiYWVmRUgzCfn7rSTKyCyOklT2zSqceKtPVlI4nov80dqomEJcwa5lKOC/aCQy774o
 38ng8NpyDCj/kMkhR24tuMMN4d/UpNv/niTLQCsqFBGWMAnFsN/DfeODKjkG3SOukiU1
 R3p3dRjl1J8ogfi+1dhnyICljQu59RKLb3u7ekytggeZgvI/L8W0+k1OW+ikYmPu6p52
 5K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784799473; x=1785404273;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oPUgpb0frsnp1JVUTki2lmBuU8fGYW5E1pXwN+DTdbc=;
 b=KlK3F2tO36QLq4NOw03XNdEqjjJOEYVF+1U9y2RtsM2Yt/na7COuK2sx0Y1YQDvLdV
 xe5o7vYOgC1OQk0d9GF3mkz2yGOfSrq42BHrUQK06kuBrYeMjCYuyQl5mi2wC8vc95/M
 AcHotLAwb8JN6PPmzd+knb3LLTgUpGYxZRNUCjcjmC8W0qp4t5FY0UOO4G9hlrHVs+f8
 hYv/wzgyfmGgIKAxqJYUqSfULU7V7/qm0VL40zUs0N5bUgEsyNshxEsKpc7FxFQn06Ga
 GJJ1lSLRdhE+hP25dMOnhDHzT8Mkhy0DhyQThifyZDtf5aY7eEDIhKYm2ai2Tw8p7b9/
 9gxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9/kSVSJtPH0V6jyowESmQaJvgswKVsdA1vLGOfQ7OPb1R2EPwCq/Jxz6CO+Xbj9vu1z2x+ZY/qak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz16B19Uu7w3KM8bMwCcdg0fsE7QaGBqCUARrhFDlJkvn42Lvx8
 hqMorCFAweGRRqbN16rgAY4GdWfdxoqOIU1bozebXL5SQ1eZjBIBXqjD
X-Gm-Gg: AR+sD116e1g0jZI8dZOTdQw4zqKqe/xjgscLFfVkARwJ3Qfpm9QRYVyi0SXW2PH0sX9
 6uLb20YDM+cKrWwD45qWf/yTBH8gCt663ERUTIGhMgmDOvtb6kElhN/z830zUrdivXNnThlEqWu
 3QeWm9Ka3z7yX+24AhfYt2msuR6F2EjsUk5/2Ii4sZii1fp99KovKQ1dFUoJgIWr/kzms8xOMTb
 xJ8FThMRXmyFTKtarPiiPfAW7kn7MtwPS+R+ONsS/e4iAZgcvt6yfyfOkBj0ZxCSAp7w1PQZ9xm
 1YuJq5kve0iE6gd77EelI4GnlPTPO8WphPGjqOxaETFdg6Fr/Daezv2JoPS4lHbtcnHjli8f2Cj
 l5l22mN2n6amUnKP9ObZYjwXBqhZQT/Crr0NfB3xZn3/UU++UkAaCCRhikBLKaLbk7UVAQA0N1b
 kr4EsOghzODx70EHWL1G41L97wLFQKUGtiLYlNnUxqXGV7JM7U
X-Received: by 2002:a05:6a00:409a:b0:847:8650:69cd with SMTP id
 d2e1a72fcca58-84e2bd889a5mr3035099b3a.33.1784799472690; 
 Thu, 23 Jul 2026 02:37:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com
 ([106.51.160.24]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e175d4133sm2738565b3a.50.2026.07.23.02.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:37:51 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:07:42 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gou Hao <gouhao@uniontech.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, bharat@chelsio.com, 
 jgg@ziepe.ca, leon@kernel.org, akpm@linux-foundation.org, ynorov@nvidia.com, 
 namcao@linutronix.de, sshegde@linux.ibm.com, nilay@linux.ibm.com,
 kees@kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-rdma@vger.kernel.org, linux-mm@kvack.org, gouhaojake@163.com,
 kernel@uniontech.com
Subject: Re: [PATCH 1/4] powerpc/xive: remove dead NULL check after
 GFP_NOFAIL allocation
Message-ID: <amHgkkMT4nrWLSka@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
 <20260723081813.176792-2-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723081813.176792-2-gouhao@uniontech.com>
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

On Thu, Jul 23, 2026 at 04:18:10PM +0800, Gou Hao wrote:
> kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
> subsequent NULL check is unreachable dead code. Remove it.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>  arch/powerpc/sysdev/xive/common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index dadd1f46ec93..79d7854259cb 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
>  
>  	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
>  				 GFP_KERNEL | __GFP_NOFAIL);
> -	if (!xive_ipis)
> -		goto out_free_domain;
This will be an unused label after this.

Regards,
Mukesh
> -
>  	for_each_node(node) {
>  		struct xive_ipi_desc *xid = &xive_ipis[node];
>  		struct xive_ipi_alloc_info info = { node };
> -- 
> 2.20.1
> 
