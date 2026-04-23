Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8566AF589DD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE74310F178;
	Thu, 23 Apr 2026 14:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="cyZyZX9/";
	dkim-atps=neutral
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3DB10F178
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:28:33 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8ef2118b478so279246785a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1776954511; x=1777559311; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U8vZETDzbkQ40NDAvMNX2MsWW7x5AHD6ZgWcNohscU8=;
 b=cyZyZX9/xuqBkA+jitInlYhy0iJDLvp6Yud15JCLDV+y4HjQgTgMBekS6PhcpBwTpM
 vIRft7nz5PbFkJPIUp1s38o70OEyq1bhtlT/ZEVgqWfzB45kddSV8JII1NBNm6EzFn/W
 b+xrLwvsur0o6bpRQdipKtfwXkdsHRoRCNzrxf5yMi6nrnXy+wmNpVTzgygoFJ7MetIq
 +fO8KMk4jPsmNWPUmZpYFnf+tkWcOwwftTjPjDdYGOObVwYMMod4ossQMKiT4yKleLUu
 tilVkAJvmwisQ4a3Eeb66I2S8ahyDaUTDDvrCqOn1QU79n4hDtVqtwWtjujVGgc/uv7C
 BPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776954511; x=1777559311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8vZETDzbkQ40NDAvMNX2MsWW7x5AHD6ZgWcNohscU8=;
 b=D4xMXU6z41jAHYy9LX4lsMggVhJy8lHGdjEjQGmpfAQjz569nprqq1uIe4KS26qz6L
 tX3EBmX5to+YKR7QADPRbyAECBF1uk8fuYK5J2ViXHalkPiBxNfyOec/5ykS7NH5XEIX
 ylDLEe/6RsqABxeAWnZbC2VW7k1IEQlRD5n7LaDstzScS2wHlJrwRIWrj3qwmxpZatPl
 lpdr/vsYzHyfH5pASahSSRafdb0yqZ4STlfpyh0Hfl9GVSUCv5RwJ/0SDTMsNO54Eyo8
 gkPNbHbUYw9HSWo+fhqNPHIINXpoC4bJhCiAlZXM2OglKk45YeMVssFCvnJkET5sapYB
 0eDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2jbYv9H6VlFgGwShBnoXh4Uy21BWWQ4vVY45SYySH2SKFhLQSY4syJwE+meRDxJKanENO3yHHpt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweLTIBh/VtyZ02yjxCK1WHsX8g+vGb30z1AACJCGrIIqXFnpH3
 LQaoshldNEDwBDg/g4eM97+FsjArt1UWyr66Gj2dg7xnb4e2aAFqBBI1RnSSXQqju+k=
X-Gm-Gg: AeBDievEajCDBzNKNdPmTAvJmjuKLRymjZ5Moqwp6yhx80Ayldrd96pTsUVQDgmIttr
 rFC8m8tqz2ef3+ogcGW7VtZVde8aAeLX9FZ3Bcp5GrhR6X/XF5vmD+Z77X5RRPansGW8Qsp0JUi
 YNQRLuuOr7o1G9EndOBeEKsGEv3o2Wue6CXOcj+rNufNTBrbBMrws7DXNicmjsY9jT8E2cw7eQD
 7VMAySh85GLOWn1+0GxkvfgpWQmdg+LdF6GTdtNUSL42X5Ycq53CAsxRcx471gzmaIqbepUZxCq
 qvHh1c4gtGNRWgGQldYtjAHz01bT7acSsT6sqUPk3N9nrRwKuEks5hqVOvVjXMgmr+QXVVmoaoo
 jc4hZkzc7RSjZ1KViyZTw+z4LiHMe/zCsvueFPUmVOMmCR7V6S8ZuNzT0jX3iCA/biGtpUk9trM
 Y1idwGQoK35FJDy28LxW6KGLJZdmRIV0+WbUUISNdyQlQ6xNupuLLFvRpkvVD5B/xePIJRiGMHB
 MMmHqmGxfg6FdwD
X-Received: by 2002:a05:620a:4089:b0:8d5:bb98:f3f3 with SMTP id
 af79cd13be357-8e78f82cf44mr4032915785a.15.1776954509767; 
 Thu, 23 Apr 2026 07:28:29 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8eb3aa60b99sm1331296285a.42.2026.04.23.07.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:28:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wFv2a-0000000EFmA-3Fc7;
 Thu, 23 Apr 2026 11:28:28 -0300
Date: Thu, 23 Apr 2026 11:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260423142828.GQ3611611@ziepe.ca>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422132740.5f809bf7@shazbot.org>
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

On Wed, Apr 22, 2026 at 01:27:40PM -0600, Alex Williamson wrote:
> I don't know how to qualify the statement in the last paragraph about
> "[t]he only requirement is that the device limit the TPH to only the
> function that is perceiving them", though.  Is that implicit in being
> associated to the dma-buf for the user owned device, or is it a
> property of the suggested steering tags, that we're not validating?

It is a property of VFs and VFIO.

For instance if an insane device allows a steering tag to reach
outside the VF's memory space then it can't really be used with VFIO.

> Steering tags can induce caching abuse, as interpreted in the
> interconnect fabric, but maybe we've already conceded that as
> fundamental aspect of TPH in general.

steering tags are opaque, we don't know what a device will do when it
receives them.

The common CPU issue is indeed cache abuse, but who knows what a
device will do with them.

> So why does vfio need to be involved in any of the sequence proposed
> here?  It seems like it would be a much cleaner design, avoiding
> overloading the existing vfio feature and questionable array semantics,
> if there were a set-tph ioctl on the resulting dma-buf instead of
> making some vfio specific interface bundling creation with tph
> hints.

Realistically only VFIO dmabufs will have this property that user
space can set any TPH.

Other in-kernel drivers should accept some kind of hint from userspace
when creating their dmabuf that makes sense for their device, not a
raw TPH value. Like a GPU might accept a hint that specifies which
dielet or something like that.

So I don't see a generality here from that perspective. The generality
is that exporting drivers that can use TPH now have the option to tell
the importing driver to send them.

Jason
