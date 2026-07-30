Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74B6C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035FC10EFE7;
	Thu, 30 Jul 2026 16:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YKSWU1b6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EFDF10EFFD;
 Thu, 30 Jul 2026 16:52:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA4BD43A7C;
 Thu, 30 Jul 2026 16:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E2A1F000E9;
 Thu, 30 Jul 2026 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785430355;
 bh=3/SF2rcIDob+OJsvgKUnxzlLtV7Cho5d4qWeW/aMqHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YKSWU1b6s5ok+6SD3NJllCvDrereMWADi2zXL775eUkM4l4iqZVhgt7EUS34JzsdD
 7GUhHLDzecXtvYv5fiRFVMVbpbm4Wi3NsFLefEipeiNfeq/QTTXxWHgr9r56XdvQFo
 1sxcRP1q66GI9TA56YnR0BCCan0og63dC6qWCcfguFtSIKHcyQ3YCii0aVufotm9h7
 PYRyH/SJYDNhSeHO/irG2zpZByLN6yIlgGTc0hVrfp1sHoScMUO8mQW5Fi39V0WkLD
 JAJQwHXfi2LSQVdPgzWRepnfo4Rihg3D7szeyW6kSVdAHXHn8phltt+p4L3OIKw9cK
 HuxC2jKW1/2rw==
Date: Thu, 30 Jul 2026 18:52:25 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_vote_on/off()
Message-ID: <aht3dm6gijcltk2kblilwd33ihrapdwbco2fd5wxrqmsuppqde@3s3242otfa5h>
References: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
 <20260727161435.GA1219282@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727161435.GA1219282@bhelgaas>
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

On Mon, Jul 27, 2026 at 11:14:35AM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 27, 2026 at 11:57:38AM +0200, Bartosz Golaszewski wrote:
> > The way power sequencing works means that a call to pwrseq_power_on()
> > does not necessarily result in the pwrseq target being powered-on at
> > that time: it may have already been powered on before. Similarly: a call
> > to pwrseq_power_off() does not have to result in an actual powering off
> > of resources: there may still be other users that requested a power-on
> > before.
> > 
> > We will also introduce the concept of "non-controllable" pwrseq targets
> > soon which further increases the disconnect between the naming
> > convention and the actual semantics.
> > 
> > What consumers of pwrseq descriptors actually do is: they *vote* for a
> > powering on of a given target or retract that vote. These operations
> > could be called get/put in line with runtime PM but this could become
> > confusing since we already provide pwrseq_get/put() for a different
> > purpose.
> 
> I see the possible confusion with get/put interfaces, but "vote"
> doesn't seem exactly right because it really is refcounting, not a
> majority vote thing.
> 
> Maybe enable/disable is a possibility, since regulator_enable() and
> regulator_disable() have the same kind of refcount behavior?
> 

+1

- Mani

-- 
மணிவண்ணன் சதாசிவம்
