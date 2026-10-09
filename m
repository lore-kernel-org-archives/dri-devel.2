Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9B5CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FC610E651;
	Fri,  9 Oct 2026 14:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GC2wHIce";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C586112192
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791556590; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nXhJggP73UHG7VkWulp5vqTh3BP6i7wGtgpkYOKUPOM+U/DzbpruJR/ymLbV6W5A7VrGFJFePxlIrWKqsm5DAyOZXN0BtWbeOMX3QdQCsEWJWHImyT2Or4aWCPWTAvgvht+8O/RHlrtpjIoqWECUU/UmN5eHIImEHr+UT2Mssvs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791556590;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=g4UUnYhHV7ucZE6mbImtigGPnQ4SPA1INEgqC2/4t4M=; 
 b=BJP+s4ZrZgogIh2zHi2NnR8WAU/Lxq8QPu82ysdraYJBDRFlVTb2vRNZiklQ+ZsXrsr0XLmr1RdM+s7WLlaZNgpQM7JjqlxqDHgrgcTISm3Do4LCvFz0fAoCqjI2/n5/DRWXJO3zaRMjj4ynbkYjCMmJ/WDbI7LVNbHnHEy1I+E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791556590; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=g4UUnYhHV7ucZE6mbImtigGPnQ4SPA1INEgqC2/4t4M=;
 b=GC2wHIceWth6rBpgcOPzsl3yXK8F1YE5FnWs6ql6bagW8xh78+g7XtzA2VHQ+OIG
 35EfNElXdnDKSUeIvHcbg+KHV2qcZ0ILHmQUxTkv1HMT7AbOg6E4R6CAf1Zf5yfMlcv
 95+X5YbZersRMSj1tN6KPn77cl1Bz2t8PZkVGJAg=
Received: by smtp.zohomail.com with SMTPS id 1791556588006355.21426914343954; 
 Fri, 9 Oct 2026 07:36:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v3 07/11] drm/tyr: add VM-related ioctls
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260929-tyr-ioctls-v3-7-26955fb111d5@kylinos.cn>
Date: Fri, 9 Oct 2026 11:36:08 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev, Alvin Sun <alvin.sun@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D57A468E-4256-40EC-99BB-43B931E0D4BB@collabora.com>
References: <20260929-tyr-ioctls-v3-0-26955fb111d5@kylinos.cn>
 <20260929-tyr-ioctls-v3-7-26955fb111d5@kylinos.cn>
To: sunke@kylinos.cn
X-Mailer: Apple Mail (2.3901.100.1.1.11)
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

Hi Alvin,

> +
> +    pub(crate) fn vm_destroy(
> +        ddev: &TyrDrmDevice<Registered>,
> +        _reg_data: &TyrDrmRegistrationData<'_>,
> +        vmdestroy: &mut uapi::drm_panthor_vm_destroy,
> +        file: &TyrDrmFile,
> +    ) -> Result<u32> {
> +        if vmdestroy.pad !=3D 0 {
> +            dev_err!(
> +                ddev.as_ref(),
> +                "Invalid VM destroy pad: {:#x}\n",
> +                vmdestroy.pad
> +            );

For invalid userspace arguments, let=E2=80=99s try to use dev_dbg =
instead.

Same for other places.

> +            return Err(EINVAL);
> +        }
> +
> +        let ret: Result<u32, Error> =3D file.inner_with(|pfile| {
> +            let vm =3D pfile.vm_pool.remove(vmdestroy.id)?;
> +            vm.kill();
> +            Ok(0)
> +        });
> +        ret
> +    }
> +
> +    pub(crate) fn vm_bind(
> +        ddev: &TyrDrmDevice<Registered>,
> +        _reg_data: &TyrDrmRegistrationData<'_>,
> +        vmbind: &mut uapi::drm_panthor_vm_bind,
> +        file: &TyrDrmFile,
> +    ) -> Result<u32> {
> +        let async_flag =3D =
uapi::drm_panthor_vm_bind_flags_DRM_PANTHOR_VM_BIND_ASYNC;
> +
> +        if vmbind.flags & !async_flag !=3D 0 {
> +            dev_err!(
> +                ddev.as_ref(),
> +                "Invalid VM_BIND flags: {:#x}\n",
> +                vmbind.flags
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        if vmbind.flags & async_flag !=3D 0 {
> +            dev_err!(ddev.as_ref(), "Async VM_BIND not supported\n");
> +            return Err(ENOTSUPP);

IIRC ioctls should not return this, but EOPNOTSUPP instead.



With the changes above,

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
