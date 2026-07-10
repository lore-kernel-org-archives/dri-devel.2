Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55389C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD6810E4AC;
	Fri, 10 Jul 2026 20:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VlASjWqz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39F910E50F;
 Fri, 10 Jul 2026 20:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mbKc1/cSnSEV/apgsx5ozNRioLCTdX2qVb6//I9wooI=; b=VlASjWqzgcw0QONm2VCn9BzIJk
 mn2RdSSUjEIO5JzWmm0NECkI5oCnjfmSMQXC0ltkXJbkRdgysaJK3+O0Hj1BAFTmqQuyc96+CQijd
 ImJPaq1+68QSTSe4CVZr1+6vewHd8GF/6SfFcgMiBiKwHx49XRSSrKhVQHZ+Fup2D0lUv2libGRjO
 sgaRQmB46aZF6mbROIzJ5fwRcgCXmLJXY6cl1iWO7nMzmdx6LPQbRuV5OEesW1Pz+r4QaKiIJ9ZTa
 D+PM8H77iOfgAsWThzGhnupIr3Gcw1XxgpwacXiYkBYB4AQcIu0g/I5ob7R5PpPKivZmvq7s8sLdf
 D//CRstQ==;
Received: from 179-125-92-221-dinamico.pombonet.net.br ([179.125.92.221]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wiHRt-00D7nu-Ma; Fri, 10 Jul 2026 22:03:50 +0200
Date: Fri, 10 Jul 2026 17:03:40 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 "Sokolowski, Jan" <jan.sokolowski@intel.com>,
 "igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH i-g-t v3 0/7] add dmem_cgroups test
Message-ID: <alFQHEiMqY2QUs4n@quatroqueijos.cascardo.eti.br>
References: <20260702130108.1397444-1-cascardo@igalia.com>
 <IA4PR11MB9251D24975F81CFD242F88F299F42@IA4PR11MB9251.namprd11.prod.outlook.com>
 <akeamIYrRSTph5St@quatroqueijos.cascardo.eti.br>
 <20260707104242.teljyquxek3hdppm@kamilkon-DESK.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707104242.teljyquxek3hdppm@kamilkon-DESK.igk.intel.com>
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

On Tue, Jul 07, 2026 at 12:42:42PM +0200, Kamil Konieczny wrote:
> Hi Thadeu,
> On 2026-07-03 at 08:18:48 -0300, Thadeu Lima de Souza Cascardo wrote:
> > On Fri, Jul 03, 2026 at 09:54:14AM +0000, Sokolowski, Jan wrote:
> > > I don't know if that's a problem or not, but your patches in patch series are titled as v2 instead of v3, at least that's how I see them.
> > > 
> > > Jan
> > > 
> > 
> > I decided to name this one v3, though I did not call the previous one v2,
> > because I have submitted a patchset earlier that was on top of Thomas
> > Hellström patchset.
> > 
> > I think it tracks the history of the patchset better. I am sorry if this
> > got confusing.
> > 
> > Cascardo.
> > 
> 
> Please keep versioning the same across series, if your cover letter
> has v3, all patches in series should also have v3.
> 
> Regards,
> Kamil

Ah, I missed that and didn't notice when sending. I will make sure
everything is v4 when I send the next version.

Cascardo.
