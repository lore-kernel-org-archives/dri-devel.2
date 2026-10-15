Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024A4CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E918112387;
	Thu, 15 Oct 2026 14:41:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE528112387
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:41:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7CF641A9E;
 Thu, 15 Oct 2026 14:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1281F000C4;
 Thu, 15 Oct 2026 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792075272;
 bh=ko1HhAJDiqoPsAWcm9xKr0vClyTmjO74NWIUdIIyJqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dgcrrvVBKLnbSosDw6lTvQBiAfdO7zGD7VVw8XjU+iaatXr5a3w1GfNayfnEcYUR7
 zUPVki7f+bauiXiE2vnocxhk/TdO1Ib+5kFHSbvaMDf03Uv7eVX5Q/xYvK0GDaEYfk
 9+4HtLEBmLc6fWxBlPFG1yQd0SFRGXWko/RTWFfeoDk6lHDq63x/Tt1Ic/3WtEDmYL
 1u72QHA5+KjbcBIy0Qldskhhgcn5DWOXfBGLzn/P1AjrjkjFQk6GjuELeVle2h+Xs+
 wygM8mZz5bUEVcfNPfydFAzGcD+JEf04x+aoOqZiEkk49TWtd4xaYXonL5Sn14/3bH
 5falOux4S38Vg==
Message-ID: <sashiko-outbox-172971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 14/15] misc/arm-cla: Support exclusive context
 assignment
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>
In-Reply-To: <20261015142552.4128028-15-ryan.roberts@arm.com>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-15-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:41:11 +0000
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
- [High] cla: missing KVM refcount failure handling causes UAF
--

commit 2dbcc26b5b7fa32dbb9707b12991d8ab79134d92
Author: Jean-Philippe Brucker <jpb@kernel.org>

misc/arm-cla: Support exclusive context assignment

This commit introduces a nr_contexts member to cla_domain to track mapped
contexts. It allows PL0 contexts to share the domain while enforcing
exclusive assignment for PL1 contexts by using a negative count.

> diff --git a/drivers/misc/arm-cla/cla-ctx.c b/drivers/misc/arm-cla/cla-ct=
x.c
> index 0489bf7a103f9..f956cc88909f8 100644
> --- a/drivers/misc/arm-cla/cla-ctx.c
> +++ b/drivers/misc/arm-cla/cla-ctx.c

[ ... ]

> @@ -116,6 +153,8 @@ struct cla_ctx *cla_ctx_create(struct cla_domain *dom=
ain,
>  		cla_ctx_put_pl1(ctx);
>  	}
>  	kfree(ctx);
> +err_put_domain:
> +	cla_domain_put(domain);
>  err_unlock:
>  	mutex_unlock(&domain->lock);
>  	return ERR_PTR(ret);

[Severity: High]
Earlier in cla_ctx_create(), if cla_ctx_get_pl1() fails to acquire a
reference to KVM (e.g., if the VM is being torn down concurrently and its
refcount is already zero), the failure is ignored:

	} else {
		WARN_ON(!cla_ctx_get_pl1(ctx));
	}

The context creation continues with a potentially freed KVM pointer. If an
error occurs later in the function (such as cla_mtc_get_ctx() failing) and
we take the err_free path, or when the context is eventually destroyed,
cla_ctx_put_pl1() is unconditionally called.

Does this cause a use-after-free and a refcount underflow of the kvm
object, since the reference was never actually acquired?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015142552.4128=
028-1-ryan.roberts@arm.com?part=3D14
