Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9CAC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8158F10EAED;
	Tue, 30 Jun 2026 06:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BfPgwQHu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BFF10EAD9
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 06:13:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D41B60008;
 Tue, 30 Jun 2026 06:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3131F000E9;
 Tue, 30 Jun 2026 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782800010;
 bh=Uw4ZJAdx6FC/kj0XgzbLUKpK0E7LlhKETbD0oKxXEmQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BfPgwQHusC2qii19LCVnHLJdCimZ2YPpHbALuEz6qXu9lZ8C22tX0nlDoxaxEr6b7
 ttCtRZeC5JhOuUahw38/6UsRZ0gx0dzDD5/P9okmCZYAcKp26pumT2tgAlb7PhtH6m
 FbC68/Q4vfcA0Vp2GqinbJPBZZW5kI4YFV5DaXUMdXwyb8+fyKAO9XZmOdaDIjcotq
 77MBGMleDsoO25oPdV4F2oz8+Q8NZgN4VwXKO3BuAHlSrrAXiWsUOGCDSBzUYigbE4
 Ryq0O8GoAbf9NTjXaPjzNBfUqXIUw7i6fZS9lIuaxEWfV0aUzLv7OV2+68rGpCmeDk
 Vzxc79BuRGrXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf/test: add KUnit case for
 dma_fence_dedup_array() empty input
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630060436.1527498-1-shoubaineng@gmail.com>
References: <20260630060436.1527498-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:13:29 +0000
Message-Id: <20260630061329.DE3131F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The newly added test_dedup_empty KUnit test will unconditionally=
 fail, breaking CI.

Pre-existing issues:
- [Critical] dma_fence_dedup_array() incorrectly returns 1 for an empty arr=
ay, causing uninitialized memory dereference in amdgpu_userq_wait_return_fe=
nce_info().
--

commit 693b63d34624f1aa69f2c97819d4a6d6655ec6bc
Author: Baineng Shou <shoubaineng@gmail.com>

dma-buf/test: add KUnit case for dma_fence_dedup_array() empty input

This commit adds a KUnit test case to verify that dma_fence_dedup_array()
returns 0 when provided with an empty array. The test aims to ensure the
documented contract is enforced and prevents future regressions.

> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-d=
ma-fence-unwrap.c
> index 4e7ee25372ba6..72dea6091d583 100644
> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c

[ ... ]

> @@ -370,6 +370,15 @@ static void test_unwrap_merge_seqno(struct kunit *te=
st)
>  	dma_fence_put(f1);
>  }
> =20
> +static void test_dedup_empty(struct kunit *test)
> +{
> +	struct dma_fence *fence[1] =3D { NULL };
> +	int ret;
> +
> +	ret =3D dma_fence_dedup_array(fence, 0);
> +	KUNIT_EXPECT_EQ(test, ret, 0);

[Severity: Medium]
Will this test fail unconditionally on the current tree?

Looking at dma_fence_dedup_array() in drivers/dma-buf/dma-fence-unwrap.c,
there is no early return for an empty array:

int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
{
        int i, j;

        sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);

        j =3D 0;
        for (i =3D 1; i < num_fences; i++) {
                ...
        }

        return ++j;
}

The loop condition i < num_fences is skipped when num_fences is 0, but the
function ends with return ++j, which returns 1. Since this patch adds a
KUnit expectation for 0, won't this cause CI to break until the correspondi=
ng
fix for dma_fence_dedup_array() is actually applied to the tree?

[Severity: Critical]
This is a pre-existing issue, but does dma_fence_dedup_array() returning 1
for empty arrays cause an uninitialized memory dereference in other
subsystems?

For example, in drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:
amdgpu_userq_wait_return_fence_info() uses kmalloc_array for the fences arr=
ay
and eventually calls dma_fence_dedup_array:

        num_fences =3D dma_fence_dedup_array(fences, num_fences);

        waitq =3D amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
        if (!waitq) {
        ...
        for (i =3D 0, cnt =3D 0; i < num_fences; i++) {
                struct amdgpu_userq_fence_driver *fence_drv;
                struct amdgpu_userq_fence *userq_fence;
                u32 index;

                userq_fence =3D to_amdgpu_userq_fence(fences[i]);

If an unprivileged user triggers a path via ioctl where 0 fences are popula=
ted
but dma_fence_dedup_array() is called with num_fences =3D 0, returning 1 wi=
ll
cause the subsequent loop to iterate once. Will this dereference an
uninitialized garbage pointer from kmalloc_array() when to_amdgpu_userq_fen=
ce()
evaluates fences[i]?

> +}
> +
>  static void test_unwrap_merge_order(struct kunit *test)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630060436.1527=
498-1-shoubaineng@gmail.com?part=3D1
