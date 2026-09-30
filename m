Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF54CA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 00:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7312B10E589;
	Wed, 30 Sep 2026 00:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nGuyX+vN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913C110E589;
 Wed, 30 Sep 2026 00:54:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DEA1600D4;
 Wed, 30 Sep 2026 00:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805711F000FF;
 Wed, 30 Sep 2026 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790729645;
 bh=eD9/5DwzOwFga3+8xXDQB0LJAO3eje1JhTX+7lHe0mU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nGuyX+vNIeI1dE9XmvAf7PSB2PIC9v+kiRfM+vvPETjPrBXpQbwRgPb2RV/vR9Xum
 9k6IANVXzeaI5pEzmLXE3NlapJVkeF+F1m4sQOCxd7/EhBozZEPzwk6MPUkSEnIA09
 Y5KM6R7cC4zO9qdWlG9vmi6fJbAJ8NYsuUOXAunvyGJodw+mnOy45mloaIsE81QemF
 5dnasMrXAuHyVTaKUzPPgjMRk/kViu/x0mg35PZtR8awXfJUuKpu6j9xPLT+6LH+lQ
 xRRu7tfViHfxauB/+WmeiNmbImI2pFmGJXT+9yqpejKve7LeWOEMbRlmpv91ZUWkMy
 dpCOk8Rh1R3iA==
Date: Wed, 30 Sep 2026 02:54:02 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH] drm/i915/gem: Prevent overstepping exec array boundary
Message-ID: <arxdlg12dVFOAI2P@zenone.zhora.eu>
References: <20260911061145.3535489-1-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911061145.3535489-1-krzysztof.karas@intel.com>
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

Hi Krzysztof,

On Fri, Sep 11, 2026 at 06:11:45AM +0000, Krzysztof Karas wrote:
> It is possible for eb_relocate_parse_slow() to call kvfree() on
> entries outside the original exec array during following
> scenario inside eb_relocate_parse_slow():
> 
> 1) eb_copy_relocations() allocates as many as eb->buffer_count
>    copies for exec entries;
> 2) eb_parse() appends up to two VMAs, right after incrementing
>    eb->buffer_count;
> 3) cleanup under "out" label uses this incremented buffer_count
>    to release relocation pointers from exec array via kvfree(),
>    not from VMA array.
> 
> To amend this problem, ensure that relocation cleanup uses the
> original exec object count, excluding the VMAs appended by the
> command parser.
> 
> Fixes: 8e4ba491b0ba ("drm/i915: Parse command buffer earlier in eb_relocate(slow)")
> Cc: stable@vger.kernel.org # 5.10+
> Assisted-by: GitHub-Copilot:gpt-6-astra
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

pushed to drm-intel-gt-next.

Thanks,
Andi
