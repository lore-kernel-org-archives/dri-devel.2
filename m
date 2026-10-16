Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCE5CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B76689C29;
	Fri, 16 Oct 2026 14:21:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C868210E1AC
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 14:21:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7A17600AA;
 Fri, 16 Oct 2026 14:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45571F000C6;
 Fri, 16 Oct 2026 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792160491;
 bh=dFzBhwDkFPwOsZeLSfCKf0dx/m1DdSIIHK+HD+S+UUQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EOSn+n0hToLCaX8bnSfZ3uWLYIdT4IAlXz2Qo5q957Yq5LYCfR8btLgeLMhLhOIEA
 KZaX+OMp6nx5+stqC3rZ+dVKK3m1UKEpJvs9KokSXZ9Kln0UN+vCJ5V4QoQh/2FrpO
 3xPGeNgSlJ0QaePJD4womy6BlYhaYD224akqz8j5t1cJD608Y/r0zoAAASfylt6OEy
 MB8B/Zu84CKdUVL7z+xpXf2xKrrsMAqeRYWTns2ntNjR8E/22Sz9Sh+jwenrCVSFjr
 EXYkQfI3VV9BJJAef6zdTB5t/ZaFwJrMDV2X2iGWlorUV9lvveYYcSZLUrpjouedIV
 a/YQ2h9Is5Iaw==
Date: Fri, 16 Oct 2026 15:22:00 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 15/15] misc/arm-cla: Add vfio-mdev user interface
Message-ID: <CABCqBse_aZL-EH0us2uA5X10q6E4WP02MoHTYf+M9ezRZr26WQ@mail.gmail.com>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-16-ryan.roberts@arm.com>
 <20261015164102.GC13920@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015164102.GC13920@nvidia.com>
X-TUID: CePXLswkibsA
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

On Thu, 15 Oct 2026 at 17:41, Jason Gunthorpe <jgg@nvidia.com> wrote:
> I think I said this last time, please don't use vfio mdev for
> anything. There is nothing mediated about this.

We don't multiplex a device between guests, but the host driver must
control part of the device registers while the remainder is assigned to
a guest. The host configures accelerator access, stage-2 translation,
handles CPUHP and context save/restore. So we can't bind the device to
vfio-platform.

Thanks,
Jean
