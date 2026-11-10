Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B27606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GOPOQG/u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8A610E088;
	Tue, 10 Nov 2026 22:59:22 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1970410E088
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 22:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794351552; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=If/e0onUz4I+mPQ8sHl1qHc9Ip9GNIBxN+9Z8eKUibTRmKBGZinqNaJDm17uSDO8tG9LICLDEjMfuK0Cxzz28c/xVm5x8c5JrwSbCLuhySSZIt0wySaJPlurw/YJohZiaQ2cGfB9Wqo0fTGFPz9UPhhnHzDHUSHyu3QwRWLChVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794351552;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=24kW4pi+WUwv2VfWtHsnjx/kdrkkrYzy3Dfi5WlWDX4=; 
 b=iCk32nINuQB419NILFHDjnOalHr3/9yP8WUC0MH48dtqRDI9szcNfFLccU4t/4t6nw22n5f3uTRRCMU1Owc8IqcH9t0noR2jdPoKfLXsJyFB6Zy1cDA1TmJpP/15HNwLgfHNZd0SX553QIAQ5fgbDK/+WOJnZyj9Pr4jLTdxoV0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
 dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=GOPOQG/u5zYLtx+cx/G2ukqSiSwkbTb3NPrf24exlaI820ZQy8eyAhlxDdGSn8QwRQMAcpMcKcHH1ZWJdHgALgI3Ybwl2ekZklQEzLyubzipxaSXH2U2tT4PCF7sHWMs1wZLZ0Gk50fSx1FL6jywJovW/n/iA2iDD5ludZJteNQ=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=24kW4pi+WUwv2VfWtHsnjx/kdrkkrYzy3Dfi5WlWDX4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1794351551030872.9024013939776;
 Tue, 10 Nov 2026 14:59:11 -0800 (PST)
Date: Tue, 10 Nov 2026 19:59:10 -0300
From: Igor Torrente <igor.torrente@collabora.com>
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: "Daniel Stone" <daniel@fooishbar.org>,
 "steven.price" <steven.price@arm.com>, "liviu.dudau" <liviu.dudau@arm.com>,
 "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
 "mripard" <mripard@kernel.org>, "tzimmermann" <tzimmermann@suse.de>,
 "airlied" <airlied@gmail.com>, "simona" <simona@ffwll.ch>,
 "dri-devel" <dri-devel@lists.freedesktop.org>
Message-ID: <1a1c7afd214.86b85fab5104718.5707465917195522525@collabora.com>
In-Reply-To: <20261110091006.60c88c61@fedora1.home>
References: <20261109105652.7114-1-igor.torrente@collabora.com>
 <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
 <20261110091006.60c88c61@fedora1.home>
Subject: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

De: Boris Brezillon <boris.brezillon@collabora.com>
Para: "Daniel Stone"<daniel@fooishbar.org>
Cc: "Igor Torrente"<igor.torrente@collabora.com>, <steven.price@arm.com>, <=
liviu.dudau@arm.com>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.=
org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dri-d=
evel@lists.freedesktop.org>
Fecha: mar, 10 nov. 2026 05:10:06 -0300
Asunto: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM

 > On Mon, 9 Nov 2026 17:38:57 +0000
 > Daniel Stone <daniel@fooishbar.org> wrote:
 >=20
 > > Hi Igor,
 > >=20
 > > On Mon, 9 Nov 2026 at 10:57, Igor Torrente <igor.torrente@collabora.co=
m> wrote:
 > > > Panthor currently does not allow exporting BOs with an exclusive VM.
 > > > However, VDRM (native context) drivers export BOs for import by the =
guest
 > > > VM, which does not attempt to bind them to any GPU VM.
 > > >
 > > > Allow these BOs to be exported and rely on
 > > > panthor_vm_prepare_map_op_ctx() to reject attempts to bind them to a
 > > > different GPU VM. =20
 > >=20
 > > I'm having a little trouble parsing this.
 > >=20
 > > Is the problem that:
 > > - the guest requests allocation of a BO with exclusive_vm_root_gem =3D=
 guest_vm
 > > - the host passes that allocation through
 > > - the host exports a dmabuf from the allocation (which fails)
 > > - the host imports a dmabuf from the allocation (?)
 > > - the guest requests the BO be attached to guest_vm
 > >=20
 > > i.e. is the problem that some host implementations (virglrenderer)
 > > handle BO allocation exclusively via an export/import interface?
 > >=20
 > > If that is the problem, it seems like it would be cleaner to have the
 > > host implementation strip the exclusive VM ID from the request, until
 > > they can be fixed to not require the export/import dance.
 >=20
 > Dropping the exclusive_vm assignment is indeed an option. The big issue
 > comes from the overhead incurred by BO access tracking when the BO is
 > shared:
 >=20
 > - bo_wait() has to do a HANDLE_TO_FD + EXPORT_SYNC dance
 > - attach_sync_point() has to do an EXPORT_SYNC_FILE + HANDLE_TO_FD +
 >   IMPORT_SYNC_FILE dance
 > - the locking of shared BOs in the GROUP_SUBMIT path is more costly
 >   (one lock per shared BO instead of one lock for all private BOs)
 >=20
 > I don't have numbers, but I suspect lowering all private BOs to
 > shared ones will have a noticeable impact on perfs.
 >=20

Continuing from the previous response:

Changing Vpipe won=E2=80=99t work. We still need to import the exclusive-VM=
 blob
to the Vpipe client, and the only way I=E2=80=99m aware of is by exporting =
the BO.

This leaves us with two possibilities: continue with this patch or strip
the exclusive-VM.

I ran benchmarks, and to my surprise, the results were very similar.

### Virtio_gpu

| Exclusive-vm | Masked | Masked[1]       | Non-masked |
|--------------|--------|-----------------|------------|
| vkmark       | 1689   | 1702            | 1760       |
| glmark       | 874    | black screen[2] | 909        |
| paraview     | 13.04  | 13.29           | 13.44      |

[1] Setting `exclusive_vm_id` as 0, but initializing `pan_kmod_bo_init`
    with the `exclusive_vm_id`
[2] `GROUP_SUBMIT failed: 22` (probably fixable)

### Vpipe

| Exclusive-vm | Masked | Masked[1] | Non-masked |
|--------------|--------|-----------|------------|
| vkmark       | 999    | 1003      | 1033       |
| glmark       | 768    | 867       | 869        |
| paraview     | 13.87  | 14        | 13.73      |

If these results are correct and representative, stripping `exclusive_vm`
seems like a viable option.

