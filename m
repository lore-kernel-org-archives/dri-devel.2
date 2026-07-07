Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4A3C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F8110EBA9;
	Tue,  7 Jul 2026 07:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfB0uizV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D5010EB9E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D347618AE;
 Tue,  7 Jul 2026 07:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD771F00A3D;
 Tue,  7 Jul 2026 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409633;
 bh=UVO2l0eGVKNtsmAWdFLKtoZMyq4dJSOu2+5aMtn+n/g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QfB0uizVfseNfmxTewRu8FAZHlmgpfF53PJBcvKx9+BQwX18Y6AAzr1D0OCDueHjP
 /RxHQDiI8aKj3wY/2DuS3XHvOBAP3F/wwiN+4k/LuwlS3xcQD4ADHQs0XVFl7OEhKL
 XH5Po2IxxHTa3b9vcOT0X0OB5gi2hXMWcVwibdoQlze6ZWBe/vQuPzhLp6/cwaroAt
 div3N9mBEYOIuv1ml/+Bs5InpLloEMuWvF9CB2qPeI6qWUFCd0DPCbfA0rOcHFqZBH
 9YsMfQtYR2jgwda9MNRJy2o9Th9yEVYyEbgDWfpCppPqgUTfFKFwTAOHtbapx692xt
 EzBSH1RlJbdsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 34/40] rcu/update: fix same dept key collision
 between various types of RCU
To: "Byungchul Park" <byungchul@sk.com>
Cc: dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org, "Anna
 Schumaker" <anna@kernel.org>, ojeda@kernel.org, tytso@mit.edu,
 "Chuck Lever" <cel@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, linux-rt-devel@lists.linux.dev,
 linux-modules@vger.kernel.org
In-Reply-To: <20260706061928.66713-35-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-35-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:52 +0000
Message-Id: <20260707073353.1CD771F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused struct member `dkey` inflates stack footprint
--

commit de6aa9797881496b4a8d7d66626b1bfd19cfdd54
Author: Yunseong Kim <ysk@kzalloc.com>

rcu/update: fix same dept key collision between various types of RCU

This commit addresses a false positive circular dependency report in dept
by assigning separate dept keys and maps to each struct rcu_synchronize
execution context.

> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -19,17 +19,20 @@ struct rcu_synchronize {
> =20
>  	/* This is for debugging. */
>  	struct rcu_gp_oldstate oldstate;
> +	struct dept_map dmap;
> +	struct dept_key dkey;

[Severity: Low]
Does this code ever use the dkey member of struct rcu_synchronize?

The _wait_rcu_gp() macro defines its own static struct dept_key __key,
which it passes as an argument to __wait_rcu_gp(). This leaves the dkey
member of struct rcu_synchronize completely unused and uninitialized, while
needlessly increasing the stack footprint of the rs_array allocated in the
macro.

>  };
>  void wakeme_after_rcu(struct rcu_head *head);
> =20
>  void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_f=
unc_t *crcu_array,
> -		   struct rcu_synchronize *rs_array);
> +		   struct rcu_synchronize *rs_array, struct dept_key *dkey);
> =20
>  #define _wait_rcu_gp(checktiny, state, ...) \
> -do {												\
> -	call_rcu_func_t __crcu_array[] =3D { __VA_ARGS__ };					\
> -	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];				\
> -	__wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array,=
 __rs_array);	\
> +do {													\
> +	call_rcu_func_t __crcu_array[] =3D { __VA_ARGS__ };						\
> +	static struct dept_key __key;									\
> +	struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];					\
> +	__wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array,=
 __rs_array, &__key);	\
>  } while (0)

[ ... ]

> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c

[ ... ]

> @@ -426,7 +426,8 @@ void __wait_rcu_gp(bool checktiny, unsigned int state=
, int n, call_rcu_func_t *c
>  				break;
>  		if (j =3D=3D i) {
>  			init_rcu_head_on_stack(&rs_array[i].head);
> -			init_completion(&rs_array[i].completion);
> +			sdt_map_init_key(&rs_array[i].dmap, dkey);
> +			init_completion_dmap(&rs_array[i].completion, &rs_array[i].dmap);
>  			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D34
