Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0E8C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE2A10F8F8;
	Fri, 25 Sep 2026 07:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="dzb+CwFB";
	dkim-atps=neutral
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4143810F6E2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:00:23 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-52fa9c055b5so11364501cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1790272822; x=1790877622; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
 b=dzb+CwFBlNImQlFO+UyzEHp/k0Y0mYrVeGkFT72B0vuGmxDL7zU/2gas2V32t/7s7k
 Zt9Lh5U9BmT3Vjvffpof65PK5zhL0R6zmCo/BNX2G3S20nxCrMudg0OeIyPuZHvhixic
 bLO+GJymlBdXKgZE12BlAfKnoEc0CaJ7UJgDMKR59V8Q1CtPviTHA301Qirtf82uKQlm
 EXVhJtuRiKLOKXDyJ5p6J+Ep9LCSvlaGdzU5DRJ39YjrgvB4FEnAiV7W/+RjtXPHDa4w
 JY4RbVvD7erQk1FJ29Vypf4gjBh07s6AZksvp9gJD99ONbBDjn32HjovNDIytBG8K9uq
 /t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790272822; x=1790877622;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
 b=Q3GAlwIXUSaKMn7BMYTpdgAfBDTNph43vrriG3wiNboCnlwtXuXA0vVJHzZFjAHeKf
 v1InvQHqTKcXGk0P6JVEnuDqYwq4B3njfK+E9Atb99fhET+2jw0HBeKKGlOzuSl+77cv
 BMtM8rRUZohReRxznf/1KND0lP1/dtVx/pnq4xOYoJSg6b9aMwWIGOxL8XxyTYmBj5VJ
 UIczKOnV1QttwbGt1RuL7g2nDdyPbp3MuARiGdomiiBvgx2fUQAXfO0L7op6Z7f9KFCP
 RPz3rSZAe7rRi/Sd83d3WOfhBTtI9TyGhS39JFVbe4CEUiZUOS6RrRw2sgycSIGAZOo8
 wInA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzanmz9H0+os0uNYPy1QoYOVmZ6TmRAuDCrOJPLOqAlf3XneAk1C9nMWhn4e4XZ/nstilYMUIZjcw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJGRGMypqGtfIe8BHm7iIsEiM5rQykZWs7NhucmkXZI3p2X7c5
 bORrxDllbGHDeI2uMPMYH4xH5BkqzOiTOH3lOWO4Mk6BUiXRdQ+ajezyubkiIMJKteI=
X-Gm-Gg: AYBFou29K35wjM03ICJ7c5lty0IF3hGchLI5f2MIbfHQvYF7aQszduihpsPsXEQX2zg
 AILsrv6xR2CQa8yCseFGpQw70cZ7Z+MgBEQhicYlAlYf/uKpfmOqZrUK6wlR4e83syDWg9dcnWD
 9jcjBUzNl8ZgDxTeIc7mOd4WlLORV3RYYsTPYZeXd4skuCxOEtGYe/sDewXfbXgpBi9GBewrokx
 w0+BXAs/RhjAjF2r4UhUI3hloMRHj9+ue8tkgH1f43RSpIOFwDzeq2v0+9M7wdXq6Idebsfs58h
 spu8bTk3R513AssBOMqhnN2uUQLggxgC6bmKMduRzl2tGvt4guYx1tNSUvZNI6+CAgLYH277CtQ
 Yu+vKvodj0AKSj/PhsykUcFpoyvqDkQh/qX40+SJnf9kkEYsMX1VCoQlawEZfq2fMcZ/RP1RJ2e
 4mC/BZvTdBaaPC57HSAac60h2b1AFqwxG5TFJb1MfWnX8FyQqc7OxJsg0BcHe8Pxo6ush9Gt8Pe
 rV0GuWpqhMZBTwurkCimEOZkgi3WwihkLLlQ2gZ/aKJwDLutHawfRA=
X-Received: by 2002:ac8:5a46:0:b0:530:e682:87c with SMTP id
 d75a77b69052e-5330b6df434mr78501cf.33.1790272821894; 
 Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532eb38d347sm47450101cf.25.2026.09.24.11.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:00:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org,
 linux-sound@vger.kernel.org, 
 bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 05/40] mm/vma: ensure mmap_prepare doesn't set actions
 on a mergeable vma
Message-ID: <arVkwC_wNoTLjRYf@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

On Thu, Sep 17, 2026 at 05:22:14PM +0100, Lorenzo Stoakes (ARM) wrote:
> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
> 
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
> 
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
> 
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/vma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index d6ed10cefc8f..62f2ce1ad5a1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2809,6 +2809,15 @@ static int mmap_validate(unsigned long prev_start, unsigned long prev_end,
>  int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
>  			  const struct vm_area_desc *desc)
>  {
> +	/*
> +	 * It is not valid to execute mmap actions for VMAs which can be merged,
> +	 * as any such merge would leave portions of the mapping incorrectly
> +	 * unmapped.
> +	 */
> +	if (vma_flags_can_merge(&desc->vma_flags) &&
> +	    WARN_ON_ONCE(desc->action.type != MMAP_NOTHING))
> +		return -EINVAL;
> +

If you wanted to make this unit-testable, you could pull it out into a
separate function:

static bool mmap_action_is_valid(const struct vm_area_desc *desc)
{
	return desc->action.type == MMAP_NOTHING ||
		!vma_flags_can_merge(&desc->vma_flags);
}

then write:

if (WARN_ON_ONCE(!mmap_action_is_valid(desc)))
	return -EINVAL;

And you can write a unit test directly against mmap_action_is_valid

otherwise

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
