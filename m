Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB56FC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2429410E39F;
	Tue, 11 Aug 2026 21:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QHqOdX3n";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A284110E39F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484898; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U9Rb2JhBu2/8ujZQ0BwDFbGsYPZOGWwXlA3RQJIlx9I2HR3RFmCqjtoHdqoA/XvMpiIMfX/Xxq9dCEOpunpY34LgdfsfXQYkaMy0lLeOv1wCt+EzeKVWQ4BdPcIYyP0ZWWfS4lCQx/PzRCm846sV8sWcrLYMDEleZ7GSg/UrCnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484898;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8dPJOsO7QwmkGfotFDEp7ajeM5F6HhDePrCAhJrbiPM=; 
 b=ck7POK3T+fvd/ZeyUKxk01WCHm5XnvTagB7N9+KaxVoe7TiXfVm88bHZL3I/+KdJnE/UbN99/bqsfxg4Ur9oKYV7pZfFkOa/YGxFb7saOg4YTewbs6ZToPuRV3Aagj1EXXRm/LxuHUhi0Bkziv67hDnYGn1IpQnz31JyrBCCflI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484898; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=8dPJOsO7QwmkGfotFDEp7ajeM5F6HhDePrCAhJrbiPM=;
 b=QHqOdX3nJQbKT5w0wrvryREH/IgLsqZe7luBUdKrgNZ2p7Gmz9YiB9jD1KZ6RFDs
 lBlSuq+4yM4sQIfxNp7LuCTgShSOgwdydficwNGEJyyPpnekC+Esh0jtteE3febhoo5
 upXjqIGIXcBrFD0Jdf3GAwZGeSWLg/4qgUlHWzXU=
Received: by mx.zohomail.com with SMTPS id 1786484896259780.0672748769396;
 Tue, 11 Aug 2026 14:48:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 3/3] drm/tyr: add GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DKLM34SJR4GR.11ABPWKZJSTK8@kernel.org>
Date: Tue, 11 Aug 2026 18:47:58 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BA7474C-3D1B-4C61-89B7-156A98AB63EE@collabora.com>
References: <20260708114358.957305-1-work@onurozkan.dev>
 <20260708114358.957305-4-work@onurozkan.dev>
 <D388C501-9903-44A7-BFD9-3BFD91502FAC@collabora.com>
 <DKLM34SJR4GR.11ABPWKZJSTK8@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

Hi Danilo,

> On 10 Aug 2026, at 19:19, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Mon Aug 10, 2026 at 9:44 PM CEST, Daniel Almeida wrote:
>> As I said on the cover letter, I'd rather keep the 'bound design for =
now,
>> leaving the door open to the Devres approach that we will eventually =
need in
>> the future.
>=20
> What exacly do you mean by this?

We have a lot of places in our downstream driver where it's not really =
clear
whether an &IoMem<'bound> and etc will be available.

E.g.: places like the submit path or the async vm_bind path, both =
invoked from
the JobQueue, which runs on its own workqueue in our downstream =
implementation.

i.e. when the JobQueue calls the driver's "submit to hardware" handler, =
Tyr needs an
IoMem to perform the mapping in the vm_bind case, or to write the =
doorbell
register in the submit case. Also places using delayed work, which is =
still
restricted to 'static workqueues IIUC.

That's what I meant by "Devres we will eventually need in the future". =
Perhaps
there is a plan to relax the 'static requirement like what happened =
recently to
the IRQ code? Because otherwise my suggestion would be try_access().

=E2=80=94 Daniel=
