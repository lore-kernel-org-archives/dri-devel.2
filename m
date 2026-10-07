Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD50CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E4810E49C;
	Wed,  7 Oct 2026 15:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="EZoQOPbP";
	dkim-atps=neutral
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8336410E49C
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 15:24:20 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3a886d6ad51so1284960a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791386660; x=1791991460;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yjoAr7VbXXfPL7miyUOSf3HSPGG+6TA/3dhUAZkacFM=;
 b=T40imb4Qn0pDIhzALY00Pc0LMbKRa99ArIoatnISQQbL+O1r5P8D/qPnTpsxeLQbyI
 aX/MBALQSvvrDBWNs9JpchHodgIFKV/MCLT6669HP2gCyxghix9r9PsTpS4XaJk0OASn
 c8uO7ID+3epU6+d5fJp/2Pq1yjjc1F+cAYjIc+cIXXWdQ9hJqz1fWpzEV2B2KuSiHB1+
 ehmmE+1njYACWe5Wyk6DCtK3oxZqANJgcvA3KTPQtr03ZtbNj4To/83CToWy7zR5PFm6
 rfX8mjkYp8t7V8uZ2AwlOs+/Z+86fh6q03fpMPE0W67Bl9hexel5+1FPEWTn6IHP3zJc
 h7hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJcPHXT9mg9iCRmEnsV0SnYLm3lWv8SNfrsWBoosgaIUdXlwDud19M4TxBlcqIuYvYhpqZVNdBems=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKEZpP+hJ7COIWe8eq2KOE3VcuzvbqFQdyieOnpcE7p0/KaYT02
 ZG74Fp9ZsXZON+O72cLgzIKZGGeHIIHr46/yG4uiC8i9hwigpj67sDf6Lvr8bhGbskZG1aRaEBJ
 AYv0Tok+dpI9ZTcy+cF25WT9v3I2q45C3ftBrl3iLUldkhR76WBwVjQXsz4tLXW2iurdeJUo6dT
 9l3gqmPhzYrwyFiAQaT3jbgNe+fWfjniojcBRRo34JPSSiQ0EAeOt4ogqsmR88UqniemI2tNji8
 dAyBvkFMCz0VeBRQYeJ
X-Gm-Gg: AYBFou3APlMd3fWKa+z6aAoROq/EYQ/JUCZGoV23JASp9zAzsX+yRt0xHQJ0iMzN/po
 d8hkWF9Xe6KVbH2gQlg5TtNgcDoRZKFKODwkbccqN0jjoEH+t+vNGcvUmSa65T92BI5xB1vxQB7
 CojCfpADmGh1dv+GvuFIbTQZAlwrANkK6LIKt+FD+cBam4Aa6SQqYpIuC0hLB355UybhVTioiVt
 Z8xjOBB4IsLm+BkwOeW9QqpUT+/Rg91dfygDNtB5Y3o7Leidmf6jDjkJ7ObgUd4vrvTIdO2h3HH
 9je9HYt3OtF/MWiLvfEYZOSW8co7Eygf5ci0RzSCr9Z2TrZZ3C4a9qBh60tZvuGAutaPOw75SqT
 k+7tprYinmVdQuACHLuIvaDlSDrO05L1E49fWgJ7hAfTIEldMROu4O1ZKN4JQ6LnJWBcpAy3AYO
 NQzJV1Nweva1uum1WiiZdQ6sZasEJ6hyIIqxI=
X-Received: by 2002:a17:90b:2ccc:b0:3a4:7730:33dd with SMTP id
 98e67ed59e1d1-3a8a1bd0bc8mr2028344a91.58.1791386659794; 
 Wed, 07 Oct 2026 08:24:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a8983a6b9fsm1283016a91.1.2026.10.07.08.24.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2026 08:24:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a99d1679ddso5906101fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791386657; x=1791991457;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yjoAr7VbXXfPL7miyUOSf3HSPGG+6TA/3dhUAZkacFM=;
 b=EZoQOPbPlD6N8B4fM1eTJYlh3STmrapOZCtuaR17Y7yvWDbz0qeyrdo2Cdqd+f8++p
 MNMZyUNS7TzMGwsZlITEH732kI810dWy7X0VK5xhHzs6cLxBAEyuDbitkprAmS9/5uMJ
 jPjeMkmb3LT+BtQKLijstM40SSqseZM5yvAhM=
X-Forwarded-Encrypted: i=1;
 AKwUvBzEkFPPNn2YkzO9PZQv1IkIsM93rjDEv6WfYmfor4XBs6JccArEH81JRau1+Uw3QXCJY16UKtRnsyI=@lists.freedesktop.org
X-Received: by 2002:a05:651c:41d4:b0:3a9:8969:3dd2 with SMTP id
 38308e7fff4ca-3a9a2d0f257mr5662851fa.13.1791386656052; 
 Wed, 07 Oct 2026 08:24:16 -0700 (PDT)
X-Received: by 2002:a05:651c:41d4:b0:3a9:8969:3dd2 with SMTP id
 38308e7fff4ca-3a9a2d0f257mr5662741fa.13.1791386655515; Wed, 07 Oct 2026
 08:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
In-Reply-To: <f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 7 Oct 2026 11:24:03 -0400
X-Gm-Features: AclHuK-7Psz2fEN6Ia0WD4-kcZK_lZfa-O4nL5-5vl9wSJCF4amtlpIyd2gj7I0
Message-ID: <CABQX2QOOaxkxzREaDHY3iXHs0106u+F9JvQSTXCnA7AEjPPxuQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Annul dmabuf->file on file release
To: Matt Evans <matt@ozlabs.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Thomas Hellstrom <thellstrom@vmware.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, Alex Mastro <amastro@fb.com>, 
 Alex Williamson <alex@shazbot.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000006734bf065d41b54d"
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

--0000000000006734bf065d41b54d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 3:15=E2=80=AFPM Matt Evans <matt@ozlabs.org> wrote:
>
> The dmabuf release path is split between file and dentry release:
> dma_buf_file_release() is called shortly before the file is freed, and
> dma_buf_release() calls an exporter's dmabuf->ops->release when the
> dentry is freed.  However, the dentry can outlive the file (for
> example, if opened with O_PATH), meaning .release might be called some
> time after the file is freed.
>
> This presents a window, when closing a DMABUF file, in which
> dmabuf->file points to freed memory yet .release op has not yet been
> called.
>
> For VFIO, if a buffer's .release has not been called it's considered
> still active and subject to move/cleanup.  If so, it attempts to
> get_file_active() on dmabuf->file: a file close with dentry held open
> will call this function with a stale pointer, a UAF.
>
> To make this pattern safe, set dmabuf->file to NULL in
> dma_buf_file_release() to reflect that the associated file is now dead
> even if the DMABUF is not yet gone.  A get_file_active() ... fput()
> sequence concurrent with a file close will only execute as one of:
>
>   - Gets the file before file_ref_put() (dmabuf->file valid)
>   - Observes dmabuf->file pointing to a file, but it's DEAD (no file)
>   - Observes dmabuf->file =3D NULL (no file)
>
> Originally, drivers could assume dmabuf->file was valid until .release
> was called from fops->release.  This assumption was no longer valid
> after 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to
> dentry_ops"), which moved the callback to the dentry release (by which
> point the file might have been freed).  With this commit, drivers must
> still consider that dmabuf->file could be NULL before .release.
>
> Fixes: 4ab59c3c638c6 ("dma-buf: Move dma_buf_release() from fops to dentr=
y_ops")
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>
> Hi,
>
> This issue was found (by Claude Opus 5.5) in the context of VFIO's
> DMABUF export path.  VFIO iterates live DMABUFs with a
> get_file_active()/fput() block, which now becomes safe if the file is
> closed (and memory freed!) yet DMABUF .release hasn't yet occurred.
>
> However, there are a couple of other places that directly use
> dmabuf->file and seem able to race a closing file (i.e. without holding
> the file reference)?  If this is so, they'd be a UAF today; with this
> patch that goes away, but instead of a stale pointer dmabuf->file could
> be NULL:
>
> 1. drivers/gpu/drm/vmwgfx/ttm_object.c:get_dma_buf_unless_doomed()
>
>   file_ref_get(&dmabuf->file->f_ref); on a non-refcounted DMABUF

Yes, that's a real UAF today. vmwgfx relied on the exporter's
dma_buf_ops.release running inside __fput() before file_free(), which
stopped being true with 4ab59c3c638c and we missed it.

But this patch on its own makes vmwgfx worse. In the ordinary case,
where closing the file drops the last dentry reference, a close racing
PRIME_HANDLE_TO_FD is safe today: ttm_prime_dmabuf_release() runs from
the same __fput() and blocks on prime->mutex, keeping the file
allocated, so file_ref_get() just fails on the dead refcount. With
this patch dmabuf->file is NULL in that window and we oops. So this
shouldn't go to stable without a vmwgfx fix.

For vmwgfx we'd probably need this one line change in
drivers/gpu/drm/vmwgfx/ttm_object.c to accompany this patch:
@@ -471,7 +475,7 @@ void ttm_object_device_release(struct
ttm_object_device **p_tdev)
  */
 static bool __must_check get_dma_buf_unless_doomed(struct dma_buf *dmabuf)
 {
-     return file_ref_get(&dmabuf->file->f_ref);
+     return get_file_active(&dmabuf->file) !=3D NULL;
 }

under prime->mutex, which keeps the struct dma_buf alive. It needs the
NULL store from this patch to fix the existing UAF, since otherwise
the recheck can accept a recycled file through the unchanged stale
pointer.

> The commit message of 90ee6ed776c0 ("fs: port files to file_ref") hints
> this might be more subtle than replacing it with a get_file() variant
> (so as to accept a NULL file *).
>
> 2. drivers/gpu/drm/i915/gvt/dmabuf.c:intel_vgpu_get_dmabuf()
>
>   gvt_dbg_dpy(... file_count(dmabuf->file) ...);
>
>
> Respective vmwgfx & i915 maintainers, what is your view?
> Or, indeed, if anyone sees any other questionable uses of dmabuf->file.
>
> Thanks,
>
>
> Matt
>
>
>   drivers/dma-buf/dma-buf.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 4c9add51f9ef..726639130477 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -193,11 +193,15 @@ static void dma_buf_release(struct dentry *dentry)
>
>   static int dma_buf_file_release(struct inode *inode, struct file *file)
>   {
> +       struct dma_buf *dmabuf =3D file->private_data;
> +
>         if (!is_dma_buf_file(file))
>                 return -EINVAL;
>
> -       __dma_buf_list_del(file->private_data);
> +       __dma_buf_list_del(dmabuf);
>
> +       /* Must be observed by __get_file_rcu() before file_free() */
> +       smp_store_mb(dmabuf->file, NULL);

I think Alex is right and dmabuf can be NULL here. An early if
(!dmabuf) return 0" will fix that.

z

--0000000000006734bf065d41b54d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFw7
JigJDzWY+MbEwLXGqD52Gt+esB7H6stgjSNjxl/bMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAwNzE1MjQxN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIoFx2Gaivx+RwlIuYDSNE7c+MFfSbDq/yu1idsl
h3E9/pNzVjxEbYUwNPuKRYkoB1vwEbqN5xK+nVkAuHbTMlkW0baLJFdJZikKLVxrinEKZTGrVFgx
3YdPvURKmo2E2HIR1X9eA+GPglyyjJBNGzfT5TVjtYqSpqGV/BZrrRCSeEuKLP69lf27tMLa7ks/
OWQ2I0HNTzsxBPtrGkpPNKhN/T6/VW32kBt75faz9phIsvkrIK9HlUdwuDRTn4f6JMGpeUOZXMQk
JhW1AAkyO+thfOgk8O4L/M7LOqmXQWBRDf4d7REflmTZl4UNm94IMmGnGXMM+QOWSIFuWY3CGMI=
--0000000000006734bf065d41b54d--
