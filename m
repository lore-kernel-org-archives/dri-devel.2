Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AEB606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=lO8vUGAB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C1710FD73;
	Thu, 19 Nov 2026 07:48:59 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2355A10FCBB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=kSUE/o5CqDYurph69R6wpud9Np7SIjoEFQ7s0L3TdZE=;
 b=lO8vUGABN3SRz8stmFI6GOw5EdtNndRF+CQvv0/fdjATmxkGTAFZQyyX
 q3S3Iji9niTjJuaRWhbudJSEAZZKtnIYWDJnU5+hLPXuIFXtC4McFue5K
 zJmH9mSahEE3uuCKvqXtwc7RUVjEQny86msZaIn/W22PRg53MToih5RN6 4=;
X-CSE-ConnectionGUID: NpDResvMRHWEoFCgk5A11w==
X-CSE-MsgGUID: tkj3zeBCTZKFS5tJsQM2+w==
Authentication-Results: mail2-relais-roc.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; d="scan'208";a="306121450"
Received: from 72-255-236-003.static.imsbiz.com (HELO hadrien) ([72.255.236.3])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 15:07:35 +0100
Date: Wed, 18 Nov 2026 22:07:31 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Bence Csokas <bence.csokas@arm.com>
cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, Nilesh Javali <njavali@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Carlos Maiolino <cem@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?ISO-8859-15?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, 
 =?ISO-8859-15?Q?G=FCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, "Geoffrey D. Bennett" <g@b4.vu>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-scsi@vger.kernel.org, 
 cocci@inria.fr, linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, 
 bpf@vger.kernel.org, ipsec@lists.linux.dev, 
 linux-security-module@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 1/2] overflow: Add offsetofend() variant of
 struct_offset()
In-Reply-To: <20261118-offsetof-v4-1-95b385c10b22@arm.com>
Message-ID: <c6fbb025-8de-b716-5d32-877c3d3fa2a6@inria.fr>
References: <20261118-offsetof-v4-0-95b385c10b22@arm.com>
 <20261118-offsetof-v4-1-95b385c10b22@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Wed, 18 Nov 2026, Bence Csokas wrote:

> Many call sites of offsetofend() use it for the purpose of pointer
> artihmetic. Thus, a common usage pattern is:
>
>   offsetofend(typeof(*ptr), member)
>
> Capturing this in one macro helps keep lines short and terse, while
> still making the purpose clear. It also helps discourage spelling out
> the type name on every callsite, leading to more maintainable code.
>
> A similar struct_offset() macro already exists, so add an offsetofend()
> variant in the same spirit.
>
> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> ---
>  include/linux/overflow.h                     | 12 ++++++++++++
>  scripts/coccinelle/api/struct_offsetof.cocci | 18 ++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index d0f04436343e..c029d68daeca 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -464,6 +464,18 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>   */
>  #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
>
> +/**
> + * struct_offsetofend() - Calculate the end of a member within a struct
> + * @p: Pointer to the struct
> + * @member: Name of the member to get the end offset of
> + *
> + * Calculates the offset of the end of a particular @member of the structure
> + * pointed to by @p.
> + *
> + * Return: number of bytes to the end of @member.
> + */
> +#define struct_offsetofend(p, member) (offsetofend(typeof(*(p)), member))
> +
>  /**
>   * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
>   * Enables caller macro to pass arbitrary trailing expressions
> diff --git a/scripts/coccinelle/api/struct_offsetof.cocci b/scripts/coccinelle/api/struct_offsetof.cocci
> new file mode 100644
> index 000000000000..5a30647d3787
> --- /dev/null
> +++ b/scripts/coccinelle/api/struct_offsetof.cocci
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use struct_offset() family of macros
> +///
> +// Confidence: High
> +// Options: --no-includes --ignore ./tools/
> +
> +virtual patch
> +
> +@offsetof depends on patch@
> +expression ptr, member;
> +@@
> +- offsetof(typeof(*(ptr)), member)
> ++ struct_offset(ptr, member)
> +@offsetofend depends on patch@
> +expression ptr, member;
> +@@
> +- offsetofend(typeof(*(ptr)), member)
> ++ struct_offsetofend(ptr, member)

Coccinelle script

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>
