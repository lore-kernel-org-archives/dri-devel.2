Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B1606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=K9AfYPfP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3745910E1CC;
	Wed, 25 Nov 2026 14:46:02 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10E410E1CC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795617952; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WdFZ7dTQSE6DloQWRHknD0sHffPMBtgWIXFcwAGszfKcB9giPTleHE+3x2TaDsOpkgxZy4ywugRKioGaYy0KjdCyJYP/+JLA4bi+lWCwwX+KOepigOUKA/HfeV96RA0ZXxTTRqX2BS5yukkCgu3VL+l9Gwblnq2IOEDkh8XG/0Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795617952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gecQT3QLi8h5ZT5ZD/aRrNShcev3mt0RHoczYfYtb44=; 
 b=AI9P4+hGOhqE+eLF6V1/AFbKTEqg04X7e4hLxipgMsvyv8gmIXBMOAUrvyvQorXEvpMScn8dFiFvLBf90QWhvnA7w/sz0ssmrBaqnQa4fp+GzBhczF+0XsuxDGd+Bd2hiMFT/gTodpQ1zjIA0O9Zv/7pEsJdjWtBAD7hOsa8ovE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=K9AfYPfPCP+VPlWTakRCodr/whi0V4yvFOpTnpk8xvcmzNssrcgDKZ9Gs0kBe4omEQ8n3SaS1RvoOOT+XANCtLJSvoWRKPVmUicpbOQEBMcxlUP429H1dS2FkgCA1WXee9rMG/Zg4xepyn86F8t+gk8jhkld3JEE1yIcTteypQ8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=gecQT3QLi8h5ZT5ZD/aRrNShcev3mt0RHoczYfYtb44=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795617950182446.68809450599986; 
 Wed, 25 Nov 2026 06:45:50 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 02/10] rust: task: add task_size()
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-ioctls-v7-2-3a2af624b992@linux.dev>
Date: Wed, 25 Nov 2026 11:45:32 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Ke Sun <sunke@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <332FBBF2-CC76-4A2C-BCB7-DCFC296B035A@collabora.com>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-2-3a2af624b992@linux.dev>
To: Alvin Sun <alvin.sun@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 22 Nov 2026, at 09:50, Alvin Sun <alvin.sun@linux.dev> wrote:
>=20
> From: Sami Tolvanen <samitolvanen@google.com>
>=20
> A DRM driver that lets userspace pick GPU virtual addresses needs the
> address space size of the calling task, so it can offer a GPU range
> that the CPU can map at the same addresses. TASK_SIZE_OF() is a macro,
> so reading it from Rust needs a helper.
>=20
> Add CurrentTask::task_size(). It is bound to the current task because
> TASK_SIZE_OF() falls back to TASK_SIZE on architectures that do not
> define it, and TASK_SIZE describes current.
>=20
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> [ Add the <linux/mm.h> include, needed where TASK_SIZE is defined in
>  <asm/pgtable.h> (e.g. riscv). - Alvin ]
> Co-developed-by: Alvin Sun <alvin.sun@linux.dev>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> rust/helpers/task.c |  6 ++++++
> rust/kernel/task.rs | 12 ++++++++++++
> 2 files changed, 18 insertions(+)
>=20
> diff --git a/rust/helpers/task.c b/rust/helpers/task.c
> index b46b1433a67e8..b49bd40027154 100644
> --- a/rust/helpers/task.c
> +++ b/rust/helpers/task.c
> @@ -1,6 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
>=20
> #include <linux/kernel.h>
> +#include <linux/mm.h>
> #include <linux/sched/task.h>
>=20
> __rust_helper void rust_helper_might_resched(void)
> @@ -13,6 +14,11 @@ __rust_helper struct task_struct =
*rust_helper_get_current(void)
> return current;
> }
>=20
> +__rust_helper unsigned long rust_helper_current_task_size(void)
> +{
> + return TASK_SIZE_OF(current);
> +}
> +
> __rust_helper void rust_helper_get_task_struct(struct task_struct *t)
> {
> get_task_struct(t);
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index a733816fd5dd4..1978f54fe5897 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -317,6 +317,18 @@ pub fn mm(&self) -> Option<&MmWithUser> {
>         Some(unsafe { MmWithUser::from_raw(mm) })
>     }
>=20
> +    /// Returns the size of the userspace address space of the =
current task.
> +    ///
> +    /// This is the first address above the userspace range, so it is =
smaller
> +    /// for a task running in compat mode than for a native one. See
> +    /// `TASK_SIZE_OF()` in =
[`include/linux/sched.h`](srctree/include/linux/sched.h).
> +    #[doc(alias =3D "TASK_SIZE_OF")]
> +    #[inline]
> +    pub fn task_size(&self) -> usize {
> +        // SAFETY: FFI call without preconditions, valid in any =
context.
> +        unsafe { bindings::current_task_size() as usize }

Do we need this cast?

> +    }
> +
>     /// Access the pid namespace of the current task.
>     ///
>     /// This function does not touch the refcount of the namespace or =
use RCU protection.
>=20
> --=20
> 2.43.0
>=20
>=20

