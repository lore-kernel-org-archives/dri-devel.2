Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D5ECA5FF5
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EDF10EF0E;
	Mon,  5 Oct 2026 22:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="SRmHVdAT";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E8C10EEFE
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 22:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791240638; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jh63C9b67OMvdyZnfpnmUZVBGeJBqq/rgdSJlrZRM7kJwpMttngOLMTK+gkhQNV6oCYCCxsXs6lW5pChc9XzWwEg2sacVdCr99BM9pj8he0zYLzlxL8FsfdRQotLwV6/YEyVzdgWxk1RfDUFEP3uGZfJAx07G6eeI0jOHkmMWZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791240638;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UbtGUo1VB4svddh9QcS4nYLUaMaEJTQQu6SoYBGLeYg=; 
 b=NwA0UtAZiWrQ8LFOL25eguMJFqKKPG89q5dRsh4h3Oju9ImqTUR2rpGpVmYpOMy+v+vWN0ZfQjgCt0JUe6LAujbtiGEAEQjPApKZwdRDghxnJOmcxQBN/CptagzTGiP9nhkM6eZ0wuT5M0znRf9zysemZnSwi4e5v4kPXTmh5KU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791240638; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=UbtGUo1VB4svddh9QcS4nYLUaMaEJTQQu6SoYBGLeYg=;
 b=SRmHVdATiV5BoSTcL/YrxVpMYyEoa8zkqWkEMuhvWwzsxp84EQBBomaRFPoJJrtk
 Lu5AM3d35lWLasYwn0azG0/Mlau2i2Lh+yI3I13gMcBZHc3wNWZMFTt9zD9u79TS8Ck
 n3Xv7Bi2wKt3k2WKuClZPQWNZIQeHWug0sdYZlFY=
Received: by smtp.zohomail.com with SMTPS id 1791240636373208.34213726082373; 
 Mon, 5 Oct 2026 15:50:36 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:50:35 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/tyr: safely write GpuInfo to userspace
Message-ID: <asQpu3c6fCt0_B5V@um790>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-2-e19bcb71980d@collabora.com>
 <DLPEHBOTZCCU.1DFPII93RC6LA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DLPEHBOTZCCU.1DFPII93RC6LA@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.236.60
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

On Sat, Sep 26, 2026 at 06:48:49PM +0200, Danilo Krummrich wrote:
> On Sat Sep 26, 2026 at 2:26 AM CEST, Deborah Brouwer wrote:
> > @@ -54,7 +54,7 @@ pub(crate) fn dev_query(
> >                      )
> >                      .writer();
> >  
> > -                    writer.write(&reg_data.gpu_info)?;
> > +                    writer.write_slice(reg_data.gpu_info.as_bytes())?;
> 
> I think we eventually want write() to require T: IntoBytes + Immutable, so I'm
> not sure there is much value going back and forth with this.

We could change UserSliceWriter::write to require T: IntoBytes + Immutable, but since
rust_binder_main.rs uses UserSliceWriter also, it’s not a trivial change.

There is value in changing this for Tyr because currently Tyr has an unsafe
implementation of AsBytes and since the panthor uapi is under development I think it
would be nicer to have a compile time check.

