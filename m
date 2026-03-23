Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8F1F483DD
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFE810E0EC;
	Mon, 23 Mar 2026 17:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lYcAXcDJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B76710E0EC
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6jsp5pl6BE8AiZ+2bUPvf03tn1StSlT2dkeyW+GDIIA=; b=lYcAXcDJ2E0KqgmaGG9Dncypon
 sKaX+qqRNMQkrQi66KUIK88RtztRuSB4Bv0qxrKG7PCX2otW9+cVnye1NaS2ZKi3102XYFKBST4r5
 CcrmvigIFemAPeFSuTiXJIE18d4ASnyGaVvHzgseZf/rpSsi/I9LebgP+JXpStmfpE1girmbFaoFy
 0Dmzux80wj1oD2EBMGleGsVuSQ14rxxH+svV/T+eATIF6MxsW9Z0nSn5uDwK9YRytaYbmvd0Rcn5z
 iOGTLnm0OE2KtpH4GYHTfVIB1AyJfhYtp2ws8c8g6UHhfXZhZoxvtBSWdzGNG24mxqWHz34ZIK4AP
 QVtBZHWw==;
Received: from [177.180.73.242] (helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w4jD9-004ynB-Cy; Mon, 23 Mar 2026 18:37:08 +0100
Date: Mon, 23 Mar 2026 14:37:00 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v2 0/3] cgroup/dmem: allow atomic irrestrictive writes to
 dmem.max
Message-ID: <acF6PMV-aezq3dWc@quatroqueijos.cascardo.eti.br>
References: <20260319-dmem_max_ebusy-v2-0-b5ce97205269@igalia.com>
 <b099d9248df084fed8d4252e3c6fc485@kernel.org>
 <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88f89d75-1e1f-4457-8c1f-57e934c251cc@lankhorst.se>
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

On Mon, Mar 23, 2026 at 05:46:28PM +0100, Maarten Lankhorst wrote:
> Hey,
> 
> 
> Den 2026-03-21 kl. 20:27, skrev Tejun Heo:
> > Hello,
> > 
> > Generally looks okay to me. One comment on 3/3 — the naked xchg() in
> > set_resource_max() needs a comment explaining why it's used instead of
> > page_counter_set_max() and what the semantics are (unconditionally sets max
> > regardless of current usage to prevent further allocations, since there's no
> > eviction mechanism yet).
> > 
> > Applied 1/3. Maarten, Michal, what do you think?
> 
> Yeah probably drop 2/3 too since there is no longer a case where setting a limit may fail.
> 
> Kind regards,
> ~Maarten Lankhorst

Actually, this can still happen if an invalid region name is given.

So, one could write:

echo -e 'region1 max\ninvalidregion2 max\n' > dmem.max

And even though setting the value for region1 would be applied, the write
would return -EINVAL.

Cascardo.
