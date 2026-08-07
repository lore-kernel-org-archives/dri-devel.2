Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75280C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD68610E3DA;
	Fri,  7 Aug 2026 06:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JQG+Okni";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1792F10E3DC;
 Fri,  7 Aug 2026 06:03:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CC2140452;
 Fri,  7 Aug 2026 06:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6771F000E9;
 Fri,  7 Aug 2026 06:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786082634;
 bh=OnjnoPTc2IU8C5hw2ZSi8CiARlOXZApAwqNm8RU5PYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JQG+OknipBtwjmOkl7R15Eji5ytxCL9qh/lVqe+DB/hJhj5SWrf+zLf4cNaj/CHCV
 xaDVax4X+pBh+FN2ei6AHbq0oyqY8A4+C0tj59Qi4UgqS8BPeLkO96Xo+LfcDtcjbP
 QoojMnK3xxD1VsakhQMR7w50A3/YBnlX6nG+3p3SmLVoHGyW4Xj8DBiUoO28VqID7I
 /y2iock8d2/fQ8Tt55Cdzl0NuuHxBxZq07PK52xtrFY3UDvLCuluegTT2Z/X5ltIbK
 uY1p1d7YLHEgIhy+Msw45EdRmIPtxMpGRNuI/9cFGi+k7kBCXMqrJRyuy+8YxhaOq7
 k5J1uKW/EV05A==
Date: Fri, 7 Aug 2026 08:03:30 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-pci@vger.kernel.org, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_enable/disable()
Message-ID: <nbsevqzspfbiptmq2mlxx2yo5z2wk5hdbc6f66yfjklmtl6hc7@ut47v44qgzgu>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
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

On Fri, Jul 31, 2026 at 03:42:18PM +0200, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> We will also introduce the concept of "non-controllable" pwrseq targets
> soon which further increases the disconnect between the naming
> convention and the actual semantics.
> 
> What consumers of pwrseq descriptors actually do is: they *vote* for a
> powering on of a given target or retract that vote. These operations
> could be called get/put in line with runtime PM but this could become
> confusing since we already provide pwrseq_get/put() for a different
> purpose. pwrseq_vote_on/off() also have been rejected as unusual in
> the tree.
> 
> Change the name of the two functions to pwrseq_enable/disable() which
> better reflects their purpose and semantics and also mirrors other
> enable-counted resources like regulators and clocks. No functional change
> intended.
> 
> If at any point users need to know *when* the exact power event happens,
> we can provide that information in the form of a notifier.
> 
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
