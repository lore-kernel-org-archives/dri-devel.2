Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82455606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=f5c2wPln
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E808F10E63F;
	Sun, 22 Nov 2026 17:14:36 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC3A310E3D9
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1795305920; x=1795565120;
 bh=GjZ15nH+Zr9dV+VfJP4mz2smNi+U2Ekt9QMOm/mP68c=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=f5c2wPlnjKmm2QADBvoaVdvS2RlJI75kJu9QhfH6gB6I1860erVlK0FcvwrTdQ5HS
 2HvN2M49tDYHjo+fmAG2QMLK2dOcx0msRyIYHvw6VOV2z9ahCPVzDPwIT7ZcIRAJVE
 /Y1t7C9bAE+rqd1YbbjEeSyf30A1oKTaN5e2AzsiFLhwmt+p4ObUp3fKK8gr2OvnZ9
 kvzqi0pRCPO1OLRVceje2OhbppdYKd6erAIpLz7qR5JCUrpNBsatQZH/Jb7KrXIUrh
 Dokc7df1Aw8/9qk8THLzNPMWIkE4w1j0i77Y9Lw3x/c+zlmXapLZBVUZN29r62JmDl
 oVEVL27kGJULw==
Date: Sun, 22 Nov 2026 00:05:17 +0000
To: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
From: Falconet3 <Falconet3@proton.me>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma-buf: fix leak of ctx and dmabuf reference in
 dma_buf_io_ctx_create() WARN path
Message-ID: <htm5h9oaY-vk0g9JVYJmz5XCaKe_nPoWkUJYJqDulyNvv_sAWfzSMp0T6GWt5okc8R4SyvXXpJQ3VGhetKnjEa2KGem5uCYdxpmdzUFf6XA=@proton.me>
Feedback-ID: 48740069:user:proton
X-Pm-Message-ID: 702b096feba5ccb2efa67b42272d49e6cc5e4207
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_abzXme9ze1hXxLPsku0U8W6cWhzMpEqIMQF3RF8w4"
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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

--b1=_abzXme9ze1hXxLPsku0U8W6cWhzMpEqIMQF3RF8w4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(leak of ctx + dmabuf ref on the WARN_ON_ONCE path, new file in v7.4-rc1, p=
atch attached)
--b1=_abzXme9ze1hXxLPsku0U8W6cWhzMpEqIMQF3RF8w4
Content-Type: text/x-patch; name=0002-dma-buf-fix-leak-in-dma_buf_io_ctx_create-WARN-path.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0002-dma-buf-fix-leak-in-dma_buf_io_ctx_create-WARN-path.patch

RnJvbTogRmFsY29uZXQzIDxGYWxjb25ldDNAcHJvdG9uLm1lPgpEYXRlOiBTYXQsIDIxIE5vdiAy
MDI2IDIxOjA1OjAwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gZG1hLWJ1ZjogZml4IGxlYWsgb2Yg
Y3R4IGFuZCBkbWFidWYgcmVmZXJlbmNlIGluIGRtYV9idWZfaW9fY3R4X2NyZWF0ZSgpIFdBUk4g
cGF0aAoKVGhlIGZpbGUgZHJpdmVycy9kbWEtYnVmL2RtYS1idWYtaW8uYyAoYW5kIHRoZSBpb191
cmluZyBkbWFidWYgcmVnYnVmCmZlYXR1cmUgb24gdG9wIG9mIGl0KSBpcyBuZXcgaW4gdjcuNC1y
YzEuIEluIGRtYV9idWZfaW9fY3R4X2NyZWF0ZSgpLAp0aGUgZXJyb3IgcGF0aCBvZiBpbml0X2Rt
YV9idWZfaW9fY3R4KCkgY29ycmVjdGx5IGRvZXMKa2ZyZWUoY3R4KSArIGRtYV9idWZfcHV0KGRt
YWJ1ZikgKGRtYS1idWYtaW8uYzoxNzgtMTgyKSwgYnV0IHRoZQpXQVJOX09OX09OQ0UoKSBwYXRo
IHJpZ2h0IGJlbG93IGl0IHJldHVybnMgLUVJTlZBTCB3aXRob3V0IGZyZWVpbmcKZWl0aGVyIChk
bWEtYnVmLWlvLmM6MTg0LTE4OCk6CgoJaWYgKFdBUk5fT05fT05DRSghY3R4LT5kZXZfb3BzIHx8
IC4uLikpCgkJcmV0dXJuIC1FSU5WQUw7ICAgICAgICAgIC8qIGxlYWtzIGN0eCBhbmQgdGhlIGdl
dF9kbWFfYnVmKCkgcmVmICovCgpSZWFjaGFibGUgZnJvbSB1c2Vyc3BhY2UgdmlhIGlvX3VyaW5n
IGJ1ZmZlciByZWdpc3RyYXRpb24KKElPUklOR19SRUdJU1RFUl9CVUYgLyByc3JjIHVwZGF0ZSB3
aXRoIElPX1JFR0JVRl9UWVBFX0RNQUJVRiwKaW9fdXJpbmcvZG1hLWJ1Zi5jIC0+IGRtYV9idWZf
aW9fY3R4X2NyZWF0ZSgpKSB3aGVuZXZlciBhbiBpbXBvcnRlcidzCmluaXRfZG1hX2J1Zl9pb19j
dHgoKSBzdWNjZWVkcyBidXQgbGVhdmVzIGRldl9vcHMgaW5jb21wbGV0ZToKa2VybmVsIG1lbW9y
eSArIGRtYS1idWYgcmVmZXJlbmNlIGxlYWsgKERvUy1ncmFkZSkuCgpBZmZlY3RzIHY3LjQtcmMx
Li52Ny40LXJjMyBvbmx5OyB0aGUgZmlsZSBkb2VzIG5vdCBleGlzdCBpbiB2Ny4zLjUuCgpGaXgg
d2FzIHZlcmlmaWVkIHdpdGggZ2l0IGFwcGx5IC0tY2hlY2sgYWdhaW5zdCB2Ny40LXJjMzsgbm90
CmJ1aWxkLXRlc3RlZCBhbmQgbm8gcmVwcm9kdWNlciBhdmFpbGFibGUgaW4gdGhpcyBlbnZpcm9u
bWVudC4KCkZpeGVzOiBGSUxMLUlOLVNIQSAoImRtYS1idWY6IGludHJvZHVjZSAuLi4gZmlsZSBJ
L08gLi4uIikKQXNzaXN0ZWQtYnk6IExMTSBNaXN0cmFsIFZpYmUKU2lnbmVkLW9mZi1ieTogRmFs
Y29uZXQzIDxGYWxjb25ldDNAcHJvdG9uLm1lPgotLS0KIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVm
LWlvLmMgfCA3ICsrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYtaW8uYyBiL2Ry
aXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLWlvLmMKaW5kZXggMDAwMDAwMC4uMDAwMDAwMCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYtaW8uYworKysgYi9kcml2ZXJzL2RtYS1idWYv
ZG1hLWJ1Zi1pby5jCkBAIC0xNzksMTMgKzE3OSwxNiBAQCBpbnQgZG1hX2J1Zl9pb19jdHhfY3Jl
YXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQlrZnJlZShjdHgpOwogCQlkbWFfYnVmX3B1dChkbWFi
dWYpOwogCQlyZXR1cm4gcmV0OwogCX0KIAogCWlmIChXQVJOX09OX09OQ0UoIWN0eC0+ZGV2X29w
cyB8fAogCQkJICFjdHgtPmRldl9vcHMtPm1hcCB8fAogCQkJICFjdHgtPmRldl9vcHMtPnVubWFw
IHx8Ci0JCQkgIWN0eC0+ZGV2X29wcy0+cmVsZWFzZSkpCi0JCXJldHVybiAtRUlOVkFMOworCQkJ
ICFjdHgtPmRldl9vcHMtPnJlbGVhc2UpKSB7CisJCWtmcmVlKGN0eCk7CisJCWRtYV9idWZfcHV0
KGRtYWJ1Zik7CisJCXJldHVybiAtRUlOVkFMOworCX0KIAogCSpvdXRfY3R4ID0gY3R4OwogCXJl
dHVybiAwOwotLSAKMi41My4wCg==

--b1=_abzXme9ze1hXxLPsku0U8W6cWhzMpEqIMQF3RF8w4--

