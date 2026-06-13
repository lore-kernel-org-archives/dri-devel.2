Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB5ECD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 16:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F4910EE0E;
	Sat, 13 Jun 2026 16:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lLQdUyax";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C4F10EE08
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 16:28:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A12B6008A;
 Sat, 13 Jun 2026 16:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92F91F000E9;
 Sat, 13 Jun 2026 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781368101;
 bh=i7NPOdcg0ztifX6GE36J122gaVUF6gDUyE6o55DTVfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lLQdUyax2Z5JCpAIVuYg1BoSJLBcAuoxGsgkOa7G1rz3tzCBFI2e/ufwMjZWFyJGA
 EsQ7ONDeoKEeiKryxtUqDywgqopUCXWAdXQ1+rz2RjIksze2eSdNIwVIu3WSXxc8Cu
 DSoAVvf/NsC6NMfaRjstmUZ0yz/a0GfRgx0vLslqo5u4N76ZdmlRS5TKbIUfj8EVLy
 f2r3U22BmK6k8EYMjG+dGQeEM5iNVRH9xKX6eRIVvLJw7EmtnkKudHH2UiqAHrrQBU
 5GIHj2XIYDSRJCJK0fZFAWoh+n7VCiI2nYCyDYmvVsSlUBEJCrCLo9RIha+D2Dgy/D
 XQingPub7Pf4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 3/4] selftests/net: ncdevmem: add -b option
 to set rx-buf-size on bind
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-tcpdm-large-niovs-v3-3-a3b693e76fcb@meta.com>
References: <20260612-tcpdm-large-niovs-v3-3-a3b693e76fcb@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 16:28:21 +0000
Message-Id: <20260613162821.C92F91F000E9@smtp.kernel.org>
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
- [Medium] The command-line parser fails to reject `rx_buf_size` values gre=
ater than 2 MB, contradicting the commit message.
--

commit 912f8a02a43d25bdd0747aae62f81533304811cd
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests/net: ncdevmem: add -b option to set rx-buf-size on bind

This commit adds a -b option to ncdevmem to set a non-default rx-buf-size.
When the requested size exceeds PAGE_SIZE, it switches to an MFD_HUGETLB
backed memfd.

>     Reject values > 2 MB up front: MFD_HUGETLB + udmabuf can only guarant=
ee
>     2 MB per sg entry (one hugepage), so a larger rx_buf_size would fail =
the
>     per-sg length/alignment check.

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/te=
sting/selftests/drivers/net/hw/ncdevmem.c
> --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
[ ... ]
> @@ -1446,6 +1463,19 @@ int main(int argc, char *argv[])
>  		case 'n':
>  			skip_config =3D 1;
>  			break;
> +		case 'b': {
> +			unsigned long val;
> +
> +			errno =3D 0;
> +			val =3D strtoul(optarg, NULL, 0);
> +			if ((val =3D=3D ULONG_MAX && errno =3D=3D ERANGE) ||
> +			    val > UINT32_MAX) {

[Severity: Medium]
The commit message mentions that values greater than 2 MB are rejected up
front, but does this parser block actually enforce that limit?=20

Looking at the validation condition here in main(), it appears to only
reject values greater than UINT32_MAX. Should this include a check against
MB(2) to prevent the per-sg length and alignment failures described in the
commit message?

> +				pr_err("invalid rx_buf_size: %s", optarg);
> +				return 1;
> +			}
> +			rx_buf_size =3D val;
> +			break;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-tcpdm-larg=
e-niovs-v3-0-a3b693e76fcb@meta.com?part=3D3
