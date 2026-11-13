Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB5606E1D6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OqxKUrma
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051F91126F2;
	Fri, 13 Nov 2026 17:00:15 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CDAB1126F2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:00:08 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a206f0b95bso127975e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:00:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589207; cv=none;
 d=google.com; s=arc-20260327;
 b=iaY9yvxg6qcNDyHq2n8zjwzsZeybqhpgbrU7Rw0l5KlTLwC5hF+6Xwt55dGc5rddJ0
 pk6IHzNwfMT+6DxSEPeXDh4weu0/CcNu/pFp9ZiyZGAHP6nf7euroFykx9aEIhuztoMR
 GEY+jI1Rdr+Q0sS4lutPq88B7Z9fUu03cHVnMWsT6NSGHbgbGAoH2HsTmdfiGRU4LpS5
 BGfPwjyayLsYBwyx3CnOlkaXoAntYYdnlHXw3A6+WcWNYPlheHSZYGptd+tknxLcq5Z5
 6v3Fc2JSN/Kz/VxEdxOUHFqQjCVzy2CWgm41GvnCR+PBYUWEyqmyRZTVjZEuLkcvajEo
 yWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=scUARIYa6JlZqbM9o9X8UDZhtH4UB7ysOYNW/jveLZY=;
 fh=FBmzKmGljruhPX82ocQn7F6CtvJK6d+pfI/7GKzDgRo=;
 b=YV6be6by3cL4lSRsbqLXt1TsTqKnYcTT54d+wsNdup29lANNSMKxYkFN9sWkTHUTBB
 Vr75e3gBeeeeZ6TghffBM/mNBcTdt340/SZini/SNcbxNUcXHT5jdnpYhOqBSksVN9b7
 O74hF05w/q2Uoi+vePGO6Vp1Jjr4S4JqIj0AaUFdPAkkMMgHIkkkFO2Bjnzr8BVPX6D6
 UYs4sS5dkVEUIiBWdYR/yGYp7MW5g+AzeqpJ25YkDkb06ZeDNtSRx91R8dZmxZ2+t0KD
 Ubs3olnMvAeeXcmk8e8QoldcYxKwIAsJWbdm7UNhWvqSjomJKZrs7mcdaSCWeWS1A6TB
 940Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794589207; x=1795194007;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=scUARIYa6JlZqbM9o9X8UDZhtH4UB7ysOYNW/jveLZY=;
 b=OqxKUrmapejuGNqbuOY4GSvebZde+jgVjrbwZJGvChtqB4v5yqIAoS3EIVNXM6Qblf
 wvaGVGUK8YjjYzsuPawXjCNnI25yuuV602Y8s3bNEhegTA5C0w/XR8alpFlQaQGP5QBd
 XCn/mXM+IL2P4j0G/FuNWpkgabOzK4s1Hor+Nj/0Y9srcHuZuDQdsLQjM6U+6NVEOzl7
 hQEHaFZeLXopD3DPerECkt9axk+2SXdbzQepm7ykoxLIa4ixrgZoV+pwpPH/R6GxCDN0
 OBo/Ot3eB2qVB2+DjA8OCPNfQDzDwdQ4mYFvbFfT/Pe8Ucd/m0grDUajrCe3xGDTNMGL
 yhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589207; x=1795194007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=scUARIYa6JlZqbM9o9X8UDZhtH4UB7ysOYNW/jveLZY=;
 b=fX905jbGGRnob3E1UqEKXWHJQHc22tf/gI7IzAnnAF5hWq3DYZ0v1ZaWLDqo32X1aD
 tKr34Lm2vyCeQ5sI08Bhbql1sKpLu+Od22YE7rU0DxFXqr0IKS00m4O9uSKU6hCehpTn
 XZka1QjvrNxjXyapcFNnnGUqXsqFP1m46rp8OoI8MKH9lxgkIv6Xrf8gGsN3O+H52joO
 LE1y2dkfdcnY6C68naupN/v+U0RXc7Fq0GwD0k7k6pzZu0gxESvAs5hngUbcx2UYKbRn
 UMBNHUCzHm5hCBEB4oRjKrZtgMZSyRHkvq/M1qRLgFECfTu0wOENRXdE24n2yq1Y1xGl
 InEg==
X-Forwarded-Encrypted: i=1;
 AL+hErGpesg1FK5KziP12sdX9rK+bRcVZ6bfEOxyZ9VHkDQcIfFYCf4SfqTY8b8hH8om67xxoMHkZO60oMw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+j1/CbYZERFSRtAGIqd/WZd7UqkmOFck8LsqKDSuGNzZ6CIbhg
 8ZcF2G4uaNPgnBbrMEVRCbAv91TM9GPBfM+xFUOgKZIh/i5yiMi4rj3H9cYr+862lYp+Madt/Cu
 cY10NwnRGrP1GD4xlc8tAb8/m9shBdGV07TOYy5Ke
X-Gm-Gg: AYBFou1Y1iP6N1eQ3SihmoF/HhGQXP4A5wrpOya5YM73vcJdjZZdpsw/z7Qy/PUl5/U
 9t0bE/G0mZh34U9sq0RxyVNyTmQMTIxgePMXW/lbDF//E6yG+5UyvJ5VBKZJHq8yaBx0oeIU2IJ
 zaQWzvMAe1pPaZ3bfvKS3TYpb7N6OgKKqjq8elF7YMzpcKDWngo2bkOafu1SIHpTud7F3XYLDvK
 tqBqsZNW3YG6V/C8in1QejlXCypl0iHiD+sUtSz0R9xGNeyIXP8PTUMdhN7aXkCNiRUQpAOFU1B
 28hkAy9VVw7W4dSQ2ioWYTd5VG2FlhxthE/Z80gXi9FuzsSJhJhxGcghugJg7Mz0dFlOIEEj5jP
 v3zaOi6n+caBdMlBs76MjrIm5H0LC+e0knJj0EeiJ80DdnmTZ7ADh19fCTYdnGh+p+9qzuhqtj+
 md7OjgaPzjJXFsxfqgDH8/9rl6
X-Received: by 2002:a05:600c:870c:b0:4a2:ba3:236e with SMTP id
 5b1f17b1804b1-4bb56e56238mr936435e9.14.1794589206285; Fri, 13 Nov 2026
 09:00:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
 <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
 <20261113035640.948458-2-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261113035640.948458-2-k.chen@smail.nju.edu.cn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 13 Nov 2026 08:59:53 -0800
X-Gm-Features: AclHuK9SEKgiz7MAOQEc_T8XPTeLCyBuqWo3mPZz76potYWEjTPup_06Sl92Rh4
Message-ID: <CABdmKX1AskqjkCcL8Xu7zqgoBCeXjoeRuQggFNxq7ktSo+ij3g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test that a drained dmabuf
 iterator keeps returning NULL
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 7:57=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> The BPF iterator docs in bpf_iterators.rst specify that the next
> function of an open-coded iterator should keep returning NULL after it
> has been returned once.
>
> Add a subtest that checks this for the dmabuf iterator.  It drains an
> iterator, calls bpf_iter_dmabuf_next() once more and checks that the
> result is NULL.  The dma-bufs the test creates keep the list from being
> empty, so an iterator that starts over would return one of them.
>
> The existing open_coded subtest uses bpf_for_each(), which stops at the
> first NULL and never calls next() on a drained iterator.
>
> The selftest was originally posted by T.J. Mercier in the v1 thread:
>
> Link: https://lore.kernel.org/bpf/CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08Kh=
WE+qJ0J=3DXGMA@mail.gmail.com/
>
> Co-developed-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

This should be:
From: T.J. Mercier <tjmercier@google.com>

<unmodified original commit message>

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>


For example see:
https://lore.kernel.org/all/20261104-v2_20230123_tjmercier_google_com-v4-1-=
1819a017000b@redhat.com/
and: https://docs.kernel.org/process/submitting-patches.html#from-line


> ---
> v3:
> - Add T.J. Mercier's Co-developed-by and matching Signed-off-by.
> - No code change.
>
>  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 19 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/dmabuf_iter.c | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools=
/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> index 1a5dc1adae73..c1f81b5dccdc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> @@ -265,6 +265,23 @@ static void subtest_dmabuf_iter_check_open_coded(str=
uct dmabuf_iter *skel, int m
>         } while (bpf_map_get_next_key(map_fd, key, key));
>  }
>
> +static void subtest_dmabuf_iter_check_next_after_drain(struct dmabuf_ite=
r *skel)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +       int err, fd;
> +
> +       fd =3D bpf_program__fd(skel->progs.iter_dmabuf_next_after_drain);
> +
> +       err =3D bpf_prog_test_run_opts(fd, &topts);
> +       if (!ASSERT_OK(err, "test_run_opts err"))
> +               return;
> +       if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> +               return;
> +
> +       /* The test buffers exist, so a restarted iteration would find on=
e */
> +       ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
> +}
> +
>  void test_dmabuf_iter(void)
>  {
>         struct dmabuf_iter *skel =3D NULL;
> @@ -315,6 +332,8 @@ void test_dmabuf_iter(void)
>         }
>         if (test__start_subtest("open_coded"))
>                 subtest_dmabuf_iter_check_open_coded(skel, map_fd);
> +       if (test__start_subtest("next_after_drain"))
> +               subtest_dmabuf_iter_check_next_after_drain(skel);
>
>  destroy:
>         destroy_test_buffers();
> diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/test=
ing/selftests/bpf/progs/dmabuf_iter.c
> index 9cbb7442646e..d5421b75c39c 100644
> --- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> @@ -99,3 +99,22 @@ int iter_dmabuf_for_each(const void *ctx)
>
>         return 0;
>  }
> +
> +/* Result of a bpf_iter_dmabuf_next() call after the iterator was draine=
d */
> +__u64 next_after_drain =3D -1;
> +
> +SEC("syscall")
> +int iter_dmabuf_next_after_drain(const void *ctx)
> +{
> +       struct bpf_iter_dmabuf it;
> +
> +       bpf_iter_dmabuf_new(&it);
> +       while (bpf_iter_dmabuf_next(&it))
> +               ;
> +
> +       /* Store the raw value; the verifier would remove a branch on it =
*/
> +       next_after_drain =3D (__u64)bpf_iter_dmabuf_next(&it);
> +       bpf_iter_dmabuf_destroy(&it);
> +
> +       return 0;
> +}
> --
> 2.34.1
>
