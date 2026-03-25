Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF682109C04D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD7410E8DC;
	Wed, 25 Mar 2026 18:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SBSGRw4/";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005C510E8DC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774462313; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KvQWx4HxrZrYYdvZSbOnixGWhlflQAmfJlqWSPAvBQisy1OmApprWPZPTIO7iJImHhOsWRc8bR8S3qOUlZAglTNTJMLDujY8Krq+tI+4z1pXz8eqsi1X1vDPBTbQjxPmzQ5VXHONLbNuufbcGshd7F4wBPqqcyBLVB2MpsiGG6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774462313;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AYVxKP58Bk5grRF6I6V018P5+nFwGJxlGe+ZLG2GXvs=; 
 b=aKqkpK80WhUioHv8oW8SSIZOXh/XEX/XLRAbRBEoRQ1YoFZ9wrF3FqplWcP2v52K7zbMnoAX9eopaGjRdycY0s3DvDLd2EXewKxGvTT4LtkQ5djB/P7N1obeoR1vUWApDZq0NwJx3jAaonF2jhHm8F3r/I3wYLIAWpFSB2DJoOU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774462313; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=AYVxKP58Bk5grRF6I6V018P5+nFwGJxlGe+ZLG2GXvs=;
 b=SBSGRw4/hdZNYQWmSstCfVaSLc1v+kcElVbCPQ/bhQU696U4iAriSjEr/q2u9IEK
 1aXzg1QnqvdVVe5RYEpwY4m1P0ZJ7HONaxzjAq3Jc6uispciOjsUmuNDaV7XPM9q3AY
 IqbNBReYc74QgIailZR7CVtOP6RvSczThpmNxm1g=
Received: by mx.zohomail.com with SMTPS id 1774462311923736.4018108026393;
 Wed, 25 Mar 2026 11:11:51 -0700 (PDT)
Date: Wed, 25 Mar 2026 18:11:48 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Janne Grunau <j@jannau.net>, kernel@collabora.com
Subject: Re: [PATCH v5 00/11] Support repeated mappings in GPUVM and Panthor
Message-ID: <acQk5DFDM0I6609-@sobremesa>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
 <CAPM=9ty41ehnPCuiwHJGtRsnrdoOL0w=hpxnA_Fi3YDo+=6dfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPM=9ty41ehnPCuiwHJGtRsnrdoOL0w=hpxnA_Fi3YDo+=6dfA@mail.gmail.com>
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

Hi Dave,

On 25.03.2026 06:51, Dave Airlie wrote:
> On Sat, 14 Mar 2026 at 01:19, Adrián Larumbe
> <adrian.larumbe@collabora.com> wrote:
> >
> > This patch series adds OP_MAP_REPEAT flag, which lets the user map a BO
> > region over an address range repeatedly with just one map operation.
> >
> > Sparse resources in the Vulkan API let the user leave regions of a
> > resource unmapped (from the API perspective.) Accesses to such regions
> > must not result in program termination, but loads produce undefined
> > values.
> >
> > To implement this feature on Mali hardware, Vulkan sparse unmap is
> > implemented by mapping the specified region to a "dummy bo" so that the
> > accesses do not fault. A newly created sparse resource starts off
> > unmapped, and therefore also has to be mapped to the "dummy bo".  This
> > "dummy bo" is small (a page size) in comparison to the sizes of va
> > ranges that we might want to map to it, and a large number of vm_bind
> > ops can be necessary. For example, if the user were to create a
> > 100e6-byte sparse resident resource, we'd have to poke VM_BIND with
> > ceil(100e6/0x1000)=24415 map operations.
>
> So other drivers pass a NULL (xe) operation to their VM BIND which
> then goes into the kernel and is handled in the backend to write the
> special sparse PT entry.
>
> Can't you just do the same thing in the driver backend, have a dummy
> bo allocated in the kernel and map the pages to it when you see a NULL
> mapping,

We could. There's been some ongoing talk among Collaborans about whether to move
all this functionality into the driver backend. We decided to keep it part of the
gpuvm core because we thought other drivers might profit from it, but if there's
no such interest, I think it's best to leave the DRM core untouched and handle
repeated mappings the way you suggested.

> or does this mess up some accounting or refcounts?
>
> Dave.

Adrian Larumbe
