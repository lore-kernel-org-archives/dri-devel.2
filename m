Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3143C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F3589DD8;
	Wed,  8 Jul 2026 14:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQXp4/qo";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3102489DD8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 14:54:29 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3800f0907d5so126640a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 07:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783522469; cv=none;
 d=google.com; s=arc-20260327;
 b=AwBQRzDIO7KLO5NkPex67NBi2ZfCqDaiXhCCU6XqWjmK5s1CLfnUMjbLUVtLIYdY2f
 Fen0BUqprUMEh4TDH3IKchXxYmiN4ddHtrVotFNj7S9ym3LaLnOz7WQxwLsvNmG66DIt
 wWMnQ4BEIHspBoIw88px6Ae02TG++mvE+nYYMLADp9jDsRFEvrczbu2HvtJ0fVO1sMiE
 sP4Ur2kRw+cnA8XOWdet6Hz4HLw8H8Tnf7xehVIBWC8rrqEDjUxPIr1g70kd45BUHLGi
 ghEpnroyxvCzOIuZj2iDQJJZeu1osNbWu8+V+xhENXYMNIJ99q1x1/Y9sqzvQZEcTpw7
 mpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JngXB7tSNiA5sHvCFVGWZTl7x6Ku33EDyxAhaDEyHww=;
 fh=pTGkgCl+QlJLG5GHdiKSe9alOXS2pAC+N0X+yBuVOHg=;
 b=QA/6wbbstbXf+S3Pr/qrjXlm+CoITiEEBG5o9LzoAxJrBG2fjHFLREFFHpHJbuwduU
 PwUiXaXZ7GtXWM4krGiKJ4hxpMweS9J29Wc4/x2HAC6QRmxaFeXyQy1piPb6KxuaFqOW
 7QDluRbCAL3V8vDpySTpmUbk8yGrjIAj+LhE+6uoBn0rM3NAe71835/TLZAM8F+26apk
 nSBilOmiF3G/qCnarPC7+9aulJZZwC8o5eXbjhjNc6GwPq03LgbxXwxq0dy3jeNDQrup
 srPQVIQpGPfPPz1zEBRMTH0uKJQT1lRpsjJMsnkiq0IJBxGKf9+IqXorH+frbVXD9xsy
 U4JA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783522469; x=1784127269; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JngXB7tSNiA5sHvCFVGWZTl7x6Ku33EDyxAhaDEyHww=;
 b=GQXp4/qoxhoZJonf/q1sl3VcEo/5yZ5rhXSwFsR1WQb0Oy2zgTS6EQmMjbVlVbU/so
 S/rA2k40vlaM5bWnZzWbmBwD+V0xqHAGsUQzWD/WfDsS0mdRIGWvbr9sh399qE/ZVsgO
 fi2v6k5rYgnwXCvO+ZEuCWkctLAv5tmmVLoXSoKNkg6ylSf7V+DE3pLF4b44yL30j++x
 4ZkePdeC3l7QhPBsljkeHJl+PBhe/ck/7t4ECpOsQ0jRyZojHTG/wCL2qDOYZYkCUVf4
 5nbBjRw2KcppPiH/rdg9s0NK5D3Ydt4EikMYfnqAzOKpAfG2p/vPRRyeuCkb0Izf88JV
 xlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522469; x=1784127269;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JngXB7tSNiA5sHvCFVGWZTl7x6Ku33EDyxAhaDEyHww=;
 b=WQuwQJNHhQi3zrPbqZhQMKImqqy5NEzK40ijsrdcVijb/jeH4a9PVl0WKzOSPiCD/S
 D20AceTrKSP5WWIhE9MzkPKrHippSszHcbkAfkaX50hOeRiDzFG7sPwH5s/ECQoyA89D
 ChXgQ2rpov0y3Lofs190l7E6dpjusgf+NKm9bl7uQosIz3pSReCtl65Dkl27fFlE+xBO
 G8b4PU3yY2PtfIRrHQ1frHtMISE6YEvXXAoz+lRc7bnfrJX4L9K/ZFFAw/bKKCDjUMfG
 +ru53IgKx9afXxTR3JB5Rxtdwwhx6wjPp/t3E3bt81IzbQDXyb7ErAjEHV3bBVeLwrw5
 Re3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHmu5Prmkol4pb9fM5iK/Z0nOuxw9yDK9xlmIBJnLMAA50wvJrYPwzTOLtSXJ+zjr0VYpASHZmJek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/gwHHdOPFbUf7XSTX1mu8vYaf8k4zfV9AggiwDtJiTnOtvlSb
 v/BCpjSnfLafvMkKVCXFwkwnVujze22i7wTa3UOITWQd7pMYuErU5V4tnjhhY7irxNE8EugzyAk
 RmusetdJe+1chO4ktHebMkdYrB1Hruy0=
X-Gm-Gg: AfdE7cl2NRcKlzrfxhOoehexjMmQ2esCibrmLBvaFhFhDIlf/Uzpa8tIhL1Xsi6VB57
 lElXYuD4/cV+JYwXcPTcdOX510HEzVGLPMCp04UJ6XWIkqVZfqKdOta6NO4ux1c42DdVfOaiADM
 C06bu5NWnnZY27eq4uFHwZgGZrIrTNFlJ42N3Wm2NTx2lXUy20nlmCDmu/1+ikqk+FR9t6Myvjr
 kuP2nJrLswlX97s09/9NDRWFZ9I88ZTZP4MzTMzeHKausXOwMd78JgsJxywVifYBILEHOwAi6jQ
 ToWsvmoDpsyhN+JSOmTa87rYbOyxq3qX9SEa/imvF0U3D8Zqz/YT138poUA=
X-Received: by 2002:a17:90a:d606:b0:36a:5438:cff4 with SMTP id
 98e67ed59e1d1-389421acc3cmr2441103a91.6.1783522468518; Wed, 08 Jul 2026
 07:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260624184444.D4A401F000E9@smtp.kernel.org>
 <20260708061835.111986-1-jhapavitra98@gmail.com>
In-Reply-To: <20260708061835.111986-1-jhapavitra98@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 10:54:16 -0400
X-Gm-Features: AVVi8CcUBVu3uqEeOCgZrUQ5dq5a_1jpu6iPGzMDECuKakm2D4qYRhlQySWtC7Q
Message-ID: <CADnq5_NyPb0XDxtJR57P8XNnhbBdpBjFFdq1zRVnzZLoZi9Vgg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP
 discovery header cast
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002f7a4206561aaf5e"
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

--0000000000002f7a4206561aaf5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 9:19=E2=80=AFAM Pavitra Jha <jhapavitra98@gmail.com>=
 wrote:
>
> Sashiko AI review of the previous fix flagged three remaining gaps in
> the discovery blob parser, all stemming from the same root cause: the
> ip_discovery_header pointer itself is constructed from a firmware-
> controlled offset with no validation before the cast.
>
>   ihdr =3D (struct ip_discovery_header *)(discovery_bin +
>                     le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
>
> This offset is a firmware-controlled u16 read directly from the
> discovery blob's table_list, with no bounds check against
> adev->discovery.size before being used to construct ihdr. Every
> subsequent read from ihdr, including num_dies and die_info[], is
> downstream of this unchecked pointer.
>
> The other two items in that review (unbounded ip_offset advancement
> via num_base_address, and num_dies exceeding die_info[]'s capacity)
> were already addressed in the previous fix.
>
> Fix by validating the table offset in amdgpu_discovery_get_table_info(),
> which is the common path used by all callers except
> amdgpu_discovery_read_harvest_bit_per_ip() (which reads
> table_list[IP_DISCOVERY].offset directly rather than going through
> get_table_info()). Add the equivalent check at that direct access site
> as well, so all paths that construct an ip_discovery_header pointer
> from a table offset are covered.
>
> The check validates the offset itself against adev->discovery.size,
> independent of any specific downstream struct size, since
> get_table_info() is shared across ten different table types
> (IP_DISCOVERY, HARVEST_INFO, GC, MALL_INFO, VCN_INFO, NPS_INFO, and
> others) each with differently-sized table structures.
>
> Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binary =
header")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>

This patch no longer applies to the current drm-next code.  I've fixed
it up and attached it here.  It was a relatively large change so I
want to make sure you are ok with it if I keep your authorship.

Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index b4ee5fc8e..9b55c56cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -564,6 +564,12 @@ static int amdgpu_discovery_get_table_info(struct am=
dgpu_device *adev,
>                 return -EINVAL;
>         }
>
> +       if (le16_to_cpu((*info)->offset) >=3D adev->discovery.size) {
> +               dev_err(adev->dev, "invalid table offset %u for table_id =
%u\n",
> +                       le16_to_cpu((*info)->offset), table_id);
> +               return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
> @@ -766,6 +772,14 @@ static void amdgpu_discovery_read_harvest_bit_per_ip=
(struct amdgpu_device *adev,
>         int i, j;
>
>         bhdr =3D (struct binary_header *)discovery_bin;
> +
> +       if (le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset) >=3D
> +           adev->discovery.size) {
> +               dev_err(adev->dev, "invalid IP_DISCOVERY table offset %u\=
n",
> +                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset=
));
> +               return;
> +       }
> +
>         ihdr =3D (struct ip_discovery_header
>                         *)(discovery_bin +
>                            le16_to_cpu(bhdr->table_list[IP_DISCOVERY].off=
set));
> --
> 2.53.0
>

--0000000000002f7a4206561aaf5e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-discovery-validate-table-offset-before-IP.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-discovery-validate-table-offset-before-IP.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mrc77jw80>
X-Attachment-Id: f_mrc77jw80

RnJvbSA0YmViZGMyZjY5MTFkNWUxMTRiNmRhNTgyNzY4ODRkZWQ1OTRjYTYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZpdHJhIEpoYSA8amhhcGF2aXRyYTk4QGdtYWlsLmNvbT4K
RGF0ZTogV2VkLCA4IEp1bCAyMDI2IDAyOjE4OjM0IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gZHJt
L2FtZGdwdS9kaXNjb3Zlcnk6IHZhbGlkYXRlIHRhYmxlIG9mZnNldCBiZWZvcmUgSVAKIGRpc2Nv
dmVyeSBoZWFkZXIgY2FzdAoKU2FzaGlrbyBBSSByZXZpZXcgb2YgdGhlIHByZXZpb3VzIGZpeCBm
bGFnZ2VkIHRocmVlIHJlbWFpbmluZyBnYXBzIGluCnRoZSBkaXNjb3ZlcnkgYmxvYiBwYXJzZXIs
IGFsbCBzdGVtbWluZyBmcm9tIHRoZSBzYW1lIHJvb3QgY2F1c2U6IHRoZQppcF9kaXNjb3Zlcnlf
aGVhZGVyIHBvaW50ZXIgaXRzZWxmIGlzIGNvbnN0cnVjdGVkIGZyb20gYSBmaXJtd2FyZS0KY29u
dHJvbGxlZCBvZmZzZXQgd2l0aCBubyB2YWxpZGF0aW9uIGJlZm9yZSB0aGUgY2FzdC4KCiAgaWhk
ciA9IChzdHJ1Y3QgaXBfZGlzY292ZXJ5X2hlYWRlciAqKShkaXNjb3ZlcnlfYmluICsKICAgICAg
ICAgICAgICAgICAgICBsZTE2X3RvX2NwdShiaGRyLT50YWJsZV9saXN0W0lQX0RJU0NPVkVSWV0u
b2Zmc2V0KSk7CgpUaGlzIG9mZnNldCBpcyBhIGZpcm13YXJlLWNvbnRyb2xsZWQgdTE2IHJlYWQg
ZGlyZWN0bHkgZnJvbSB0aGUKZGlzY292ZXJ5IGJsb2IncyB0YWJsZV9saXN0LCB3aXRoIG5vIGJv
dW5kcyBjaGVjayBhZ2FpbnN0CmFkZXYtPmRpc2NvdmVyeS5zaXplIGJlZm9yZSBiZWluZyB1c2Vk
IHRvIGNvbnN0cnVjdCBpaGRyLiBFdmVyeQpzdWJzZXF1ZW50IHJlYWQgZnJvbSBpaGRyLCBpbmNs
dWRpbmcgbnVtX2RpZXMgYW5kIGRpZV9pbmZvW10sIGlzCmRvd25zdHJlYW0gb2YgdGhpcyB1bmNo
ZWNrZWQgcG9pbnRlci4KClRoZSBvdGhlciB0d28gaXRlbXMgaW4gdGhhdCByZXZpZXcgKHVuYm91
bmRlZCBpcF9vZmZzZXQgYWR2YW5jZW1lbnQKdmlhIG51bV9iYXNlX2FkZHJlc3MsIGFuZCBudW1f
ZGllcyBleGNlZWRpbmcgZGllX2luZm9bXSdzIGNhcGFjaXR5KQp3ZXJlIGFscmVhZHkgYWRkcmVz
c2VkIGluIHRoZSBwcmV2aW91cyBmaXguCgpGaXggYnkgdmFsaWRhdGluZyB0aGUgdGFibGUgb2Zm
c2V0IGluIGFtZGdwdV9kaXNjb3ZlcnlfZ2V0X3RhYmxlX2luZm8oKSwKd2hpY2ggaXMgdGhlIGNv
bW1vbiBwYXRoIHVzZWQgYnkgYWxsIGNhbGxlcnMgZXhjZXB0CmFtZGdwdV9kaXNjb3ZlcnlfcmVh
ZF9oYXJ2ZXN0X2JpdF9wZXJfaXAoKSAod2hpY2ggcmVhZHMKdGFibGVfbGlzdFtJUF9ESVNDT1ZF
UlldLm9mZnNldCBkaXJlY3RseSByYXRoZXIgdGhhbiBnb2luZyB0aHJvdWdoCmdldF90YWJsZV9p
bmZvKCkpLiBBZGQgdGhlIGVxdWl2YWxlbnQgY2hlY2sgYXQgdGhhdCBkaXJlY3QgYWNjZXNzIHNp
dGUKYXMgd2VsbCwgc28gYWxsIHBhdGhzIHRoYXQgY29uc3RydWN0IGFuIGlwX2Rpc2NvdmVyeV9o
ZWFkZXIgcG9pbnRlcgpmcm9tIGEgdGFibGUgb2Zmc2V0IGFyZSBjb3ZlcmVkLgoKVGhlIGNoZWNr
IHZhbGlkYXRlcyB0aGUgb2Zmc2V0IGl0c2VsZiBhZ2FpbnN0IGFkZXYtPmRpc2NvdmVyeS5zaXpl
LAppbmRlcGVuZGVudCBvZiBhbnkgc3BlY2lmaWMgZG93bnN0cmVhbSBzdHJ1Y3Qgc2l6ZSwgc2lu
Y2UKZ2V0X3RhYmxlX2luZm8oKSBpcyBzaGFyZWQgYWNyb3NzIHRlbiBkaWZmZXJlbnQgdGFibGUg
dHlwZXMKKElQX0RJU0NPVkVSWSwgSEFSVkVTVF9JTkZPLCBHQywgTUFMTF9JTkZPLCBWQ05fSU5G
TywgTlBTX0lORk8sIGFuZApvdGhlcnMpIGVhY2ggd2l0aCBkaWZmZXJlbnRseS1zaXplZCB0YWJs
ZSBzdHJ1Y3R1cmVzLgoKdjI6IHJlYmFzZSBvbiBsYXRlc3QgY29kZSAoQWxleCkKCkZpeGVzOiBk
MGM2NDdhNmFhZTIgKCJkcm0vYW1kZ3B1L2Rpc2NvdmVyeTogc3VwcG9ydCBuZXcgZGlzY292ZXJ5
IGJpbmFyeSBoZWFkZXIiKQpTaWduZWQtb2ZmLWJ5OiBQYXZpdHJhIEpoYSA8amhhcGF2aXRyYTk4
QGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3Zl
cnkuYyB8IDMxICsrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNjb3ZlcnkuYwppbmRleCBmMzMyNzhmY2MwZjQxLi5kNTY1ZGQ3YWJjNmZhIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jCkBAIC01NjYs
MjIgKzU2NiwzMyBAQCBzdGF0aWMgY29uc3QgY2hhciAqYW1kZ3B1X2Rpc2NvdmVyeV9nZXRfZndf
bmFtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIH0KIAogc3RhdGljIHN0cnVjdCB0YWJs
ZV9pbmZvICoKLWFtZGdwdV9kaXNjb3ZlcnlfZ2V0X3RhYmxlX2luZm9fZnJvbV9iaW4odWludDhf
dCAqZGlzY292ZXJ5X2JpbiwKK2FtZGdwdV9kaXNjb3ZlcnlfZ2V0X3RhYmxlX2luZm9fZnJvbV9i
aW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJCSB1aW50OF90ICpkaXNjb3Zlcnlf
YmluLAogCQkJCQkgdWludDE2X3QgdGFibGVfaWQpCiB7CiAJc3RydWN0IGJpbmFyeV9oZWFkZXIg
KmJoZHIgPSAoc3RydWN0IGJpbmFyeV9oZWFkZXIgKilkaXNjb3ZlcnlfYmluOwogCXN0cnVjdCBi
aW5hcnlfaGVhZGVyX3YyICpiaGRydjI7CisJc3RydWN0IHRhYmxlX2luZm8gKmluZm87CiAKIAlz
d2l0Y2ggKGJoZHItPnZlcnNpb25fbWFqb3IpIHsKIAljYXNlIDI6CiAJCWJoZHJ2MiA9IChzdHJ1
Y3QgYmluYXJ5X2hlYWRlcl92MiAqKWRpc2NvdmVyeV9iaW47Ci0JCXJldHVybiAmYmhkcnYyLT50
YWJsZV9saXN0W3RhYmxlX2lkXTsKKwkJaW5mbyA9ICZiaGRydjItPnRhYmxlX2xpc3RbdGFibGVf
aWRdOworCQlicmVhazsKIAljYXNlIDE6CiAJY2FzZSAwOgotCQlyZXR1cm4gJmJoZHItPnRhYmxl
X2xpc3RbdGFibGVfaWRdOworCQlpbmZvID0gJmJoZHItPnRhYmxlX2xpc3RbdGFibGVfaWRdOwor
CQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXR1cm4gTlVMTDsKIAl9CisKKwlpZiAobGUxNl90b19j
cHUoKGluZm8pLT5vZmZzZXQpID49IGFkZXYtPmRpc2NvdmVyeS5zaXplKSB7CisJCWRldl9lcnIo
YWRldi0+ZGV2LCAiaW52YWxpZCB0YWJsZSBvZmZzZXQgJXUgZm9yIHRhYmxlX2lkICV1XG4iLAor
CQkJbGUxNl90b19jcHUoKGluZm8pLT5vZmZzZXQpLCB0YWJsZV9pZCk7CisJCXJldHVybiBOVUxM
OworCX0KKwlyZXR1cm4gaW5mbzsKIH0KIAogc3RhdGljIGludCBhbWRncHVfZGlzY292ZXJ5X2dl
dF90YWJsZV9pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LApAQCAtNTkxLDcgKzYwMiw4
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9nZXRfdGFibGVfaW5mbyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAlzdHJ1Y3QgYmluYXJ5X2hlYWRlciAqYmhkciA9CiAJCShzdHJ1
Y3QgYmluYXJ5X2hlYWRlciAqKWFkZXYtPmRpc2NvdmVyeS5iaW47CiAKLQkqaW5mbyA9IGFtZGdw
dV9kaXNjb3ZlcnlfZ2V0X3RhYmxlX2luZm9fZnJvbV9iaW4oYWRldi0+ZGlzY292ZXJ5LmJpbiwK
KwkqaW5mbyA9IGFtZGdwdV9kaXNjb3ZlcnlfZ2V0X3RhYmxlX2luZm9fZnJvbV9iaW4oYWRldiwK
KwkJCQkJCQkgYWRldi0+ZGlzY292ZXJ5LmJpbiwKIAkJCQkJCQkgdGFibGVfaWQpOwogCWlmICgh
KmluZm8pIHsKIAkJZGV2X2VycihhZGV2LT5kZXYsICJJbnZhbGlkIGlwIGRpc2NvdmVyeSB0YWJs
ZSB2ZXJzaW9uICVkXG4iLApAQCAtODAzLDYgKzgxNSwxNCBAQCBzdGF0aWMgdm9pZCBhbWRncHVf
ZGlzY292ZXJ5X3JlYWRfaGFydmVzdF9iaXRfcGVyX2lwKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogCWludCBpLCBqOwogCiAJYmhkciA9IChzdHJ1Y3QgYmluYXJ5X2hlYWRlciAqKWRpc2Nv
dmVyeV9iaW47CisKKwlpZiAobGUxNl90b19jcHUoYmhkci0+dGFibGVfbGlzdFtJUF9ESVNDT1ZF
UlldLm9mZnNldCkgPj0KKwkgICAgYWRldi0+ZGlzY292ZXJ5LnNpemUpIHsKKwkJZGV2X2Vycihh
ZGV2LT5kZXYsICJpbnZhbGlkIElQX0RJU0NPVkVSWSB0YWJsZSBvZmZzZXQgJXVcbiIsCisJCQls
ZTE2X3RvX2NwdShiaGRyLT50YWJsZV9saXN0W0lQX0RJU0NPVkVSWV0ub2Zmc2V0KSk7CisJCXJl
dHVybjsKKwl9CisKIAlpaGRyID0gKHN0cnVjdCBpcF9kaXNjb3ZlcnlfaGVhZGVyCiAJCQkqKShk
aXNjb3ZlcnlfYmluICsKIAkJCSAgIGxlMTZfdG9fY3B1KGJoZHItPnRhYmxlX2xpc3RbSVBfRElT
Q09WRVJZXS5vZmZzZXQpKTsKQEAgLTEzMjksNyArMTM0OSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X2Rpc2NvdmVyeV9zeXNmc19yZWN1cnNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXNp
emVfdCBpcF9vZmZzZXQ7CiAJaW50IGlpLCByZXM7CiAKLQlpbmZvID0gYW1kZ3B1X2Rpc2NvdmVy
eV9nZXRfdGFibGVfaW5mb19mcm9tX2JpbihkaXNjb3ZlcnlfYmluLAorCWluZm8gPSBhbWRncHVf
ZGlzY292ZXJ5X2dldF90YWJsZV9pbmZvX2Zyb21fYmluKGFkZXYsCisJCQkJCQkJZGlzY292ZXJ5
X2JpbiwKIAkJCQkJCQlJUF9ESVNDT1ZFUlkpOwogCWlmICghaW5mbykKIAkJcmV0dXJuIC1FSU5W
QUw7Ci0tIAoyLjU1LjAKCg==
--0000000000002f7a4206561aaf5e--
