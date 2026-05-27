Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9470CCD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7150F10ED15;
	Thu, 28 May 2026 07:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJip6g/m";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E3F10E0E5
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:34:06 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7c04749d739so80513407b3.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 07:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779892445; cv=none;
 d=google.com; s=arc-20240605;
 b=kv7B+60L99ZhgvvuPvZk9Fp0X0ZgQpNA4OmrH3qBYGKRC+Vo5wJi8OQtyCIHx6dw03
 W/8NVUm+j1mnmzWDErk9bhfALQ2xq0nL7PnyIy4Uve5FLFIor2evuTLDJ2X4gYvaSlsC
 OYEsJ3K+9firYd+6nkceN6z3qiPnAoQUbhHudD7YkwvtYD/L4vzg293/wpQp/uaYLJsW
 MXw8PQfWEGTo1cnu9qsX+y8T9RqSXbrxlT5RRMeRiFMc/SIAJX9Lae3hJ0puIuML4jhN
 /rnHYWj14EixN2X0g4b4BHN6hVTwgsHLR+VpSMns6z7ivmZ7dscA9bQhCQ3wI5gYx3lS
 02EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=fJqar9L8+eehteUQWsu1NTNv62PRoS7/WvyShE2hN8Y=;
 fh=oIx1LRsS5li60AsN4oH8G4Pnq8Bs3IXxtPsgD0NMDt0=;
 b=b+L00Kr/KV1qMFr1VJwPzVy4t2cYpm+51QJngOeRjxZq2ki29aSS5HxsgTZ6+IviS0
 GllunisrtxE8/KQqIVoQZZZSyt7AvWL8J/rXoumC1h1tVOwXpvLTuTH/xb5SHaPxZdc8
 SNfINEOY+Q4py5HS7cQ25WdJZqawbUSrGQSGpCMLt/mhF5XiJEx5XAedccVKXOS71GG5
 w/ZE67XbsxIlNDAcXeWYF7jOSVslV94oUGOJWykKkRxqQuAK1WayiqEw8chmvypNM6HW
 cWQJhmzA8TvMnaTTBNnRbryooV94K6RdldJYZSz88O4XAPlGw8vndogvKecI+/utxevE
 e2IA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779892445; x=1780497245; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fJqar9L8+eehteUQWsu1NTNv62PRoS7/WvyShE2hN8Y=;
 b=AJip6g/m1DYuFsKNgsBT5qm5Od2RK0zNukNBxayZwxot9uVTW5DmlNrZ64SjVMyEuZ
 lHRXC3WyxvN7lTlfjDX7jtvrTl+JU6MXBnoTj0HL1prXOcGrZ7Du2Tb6hvbfFax7fWOh
 Zbs5U/mB63GWkMDxk020CyCwxkUJVV86KZTcg3xuiwHdmAUjFTyACDrrXfHLI0HE4Zjk
 6lMkLNSjqHppGmq8KLztOoIkFt+natWqKhgk9WdWfIq/YqGcvI4E+01HkTGC/WyknE9/
 932NcRmfeDUtQ6euUjJ3F9qNwqacYcyVrspXLi8FVflSvM6ys+oxeJ1pqgNjBCK4K8WQ
 zK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779892445; x=1780497245;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJqar9L8+eehteUQWsu1NTNv62PRoS7/WvyShE2hN8Y=;
 b=be/i0yWNQQBLDgCa6zlLICyrtHzm0d7l6DyETKX7ZgKWovT/Lm9x/wHKL4jPzogH+z
 4eyVwhj1m5ZF8xVabcrFt53rm+VzXNqTNx3vWkNz4TPj5+ZapXC03N2OjW5YuwQU6Cf3
 p+6SRm3ICEyj6thtBmU6Frnpewhhd+BUZ6f1Qu+Q/wvhdu2h6mvwSK4EGFFKBkaF5RA/
 ZCqE8S/VBlnMmQJmbf8mDpAV2gsGcF9W1q2wH4FHcjLN6GY3XFf2Ntf6Vm35dArApSHQ
 bYhU8aCewxHKSPGtvVlS8jTPDFvv6m4YqiviqeCnocb4KxC2NfCV/x7GLkt3OPyDJ/Kx
 mfyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8V6kqpZkjqcpuGTccLVcuuqnsf27Q10LMJ6Dep3GJP9Tq3fO+6Xzc1s/ZqH1890RWd7XM1Kmy70Ng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwJwGr5HPvz3P8HQK9DOFW8ZPYk02KtALsU7aSg07DJLTLLMRE
 lL2Qrur1MYuyS/W0bHIx4bG68pQgWB4VbkPTeWtCfnsRZ2gSqpqXH9Yb887Nw+L/DrP/kHWrJsA
 qWbjMGBH9r4wtEpZRbS0haKEX31Ltl2w=
X-Gm-Gg: Acq92OFBsA5veCsbuPUS8LJTQ+cib2O7shlHLs+wHmA30PyWXf+rAPisswSiEb9pu/+
 vYN76cKh09nAogwFWxiCSIOYEw59zoUnjKclDlUVluE0DBeNugLmmY8Y0QGpvbVNFKUs/t8fyAb
 QSKyqmdCRIioQUAmN4wyw0HmSI158IeEDdIGf4M270SKQrtdcP3X7ZvBiOmd2vvXIQ/Sz35MO5o
 H1czVYjuC47GDUwihAEc0UGm75/qvZuk8/vpCUa3KuhVLZbx7um8UTPnSxZCDkQwa7iQUGCyL64
 NOWVYCQCW3vCiE5RnXIqz7dGMI7exaCuqYIDwQujI5EhkZ03zgihC13JsP9wshuUnM5h8vSp
X-Received: by 2002:a05:690c:4883:b0:7d1:c256:b5a8 with SMTP id
 00721157ae682-7d33ac50c26mr243122427b3.40.1779892445243; Wed, 27 May 2026
 07:34:05 -0700 (PDT)
MIME-Version: 1.0
From: D D <dhabal123@gmail.com>
Date: Wed, 27 May 2026 20:03:54 +0530
X-Gm-Features: AVHnY4Kl2ZqhbWmLaEFG8Y_w8kAUZeskqipdE5ovkgAii9kaO-bxgRxmvCIQIf8
Message-ID: <CA+g3TbucTCsgvGaywNqyZdh5g-889zK06WZ57Mpxm1qOpgYTfA@mail.gmail.com>
Subject: [PATCH 0/2] accel/rocket: Fix NULL deref and double-free in job
 submit error path
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: simona@ffwll.ch, airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f022500652cd8029"
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:17 +0000
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

--000000000000f022500652cd8029
Content-Type: text/plain; charset="UTF-8"

Hi Tomeu,

Two bugs in the job submission error path in rocket_job.c:

1) rocket_job_cleanup() unconditionally calls
   rocket_iommu_domain_put(job->domain), but job->domain is only
   assigned after all fallible operations in
   rocket_ioctl_submit_job(). On early failure, job->domain is NULL,
   causing a NULL pointer dereference.

2) rocket_copy_tasks() frees rjob->tasks on its error path but does
   not NULL the pointer. rocket_job_cleanup() frees it again,
   resulting in a double-free.

Patch 1 adds a NULL check for job->domain in rocket_job_cleanup().
Patch 2 sets rjob->tasks to NULL after freeing in rocket_copy_tasks().

Dhabaleshwar Das (2):
  accel/rocket: Add NULL check for domain in rocket_job_cleanup()
  accel/rocket: Fix double-free of tasks array in rocket_copy_tasks()

 drivers/accel/rocket/rocket_job.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Thanks,
Dhabaleshwar Das

--000000000000f022500652cd8029
Content-Type: application/octet-stream; name="Bug2_patch2_double_free.patch"
Content-Disposition: attachment; filename="Bug2_patch2_double_free.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpo5vs6j0>
X-Attachment-Id: f_mpo5vs6j0

RnJvbTogRGhhYmFsZXNod2FyIERhcyA8ZGhhYmFsMTIzQGdtYWlsLmNvbT4KRGF0ZTogV2VkLCAy
OCBNYXkgMjAyNiAwMDowMDowMCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBhY2NlbC9yb2Nr
ZXQ6IEZpeCBkb3VibGUtZnJlZSBvZiB0YXNrcyBhcnJheSBpbiByb2NrZXRfY29weV90YXNrcygp
Cgpyb2NrZXRfY29weV90YXNrcygpIGZyZWVzIHJqb2ItPnRhc2tzIHZpYSBrdmZyZWUoKSBvbiBp
dHMgZXJyb3IgcGF0aApidXQgZG9lcyBub3Qgc2V0IHRoZSBwb2ludGVyIHRvIE5VTEwuIFdoZW4g
dGhlIGNhbGxlcidzIGVycm9yIHBhdGgKbGF0ZXIgcmVhY2hlcyByb2NrZXRfam9iX2NsZWFudXAo
KSB2aWEgcm9ja2V0X2pvYl9wdXQoKSwKcm9ja2V0X2pvYl9jbGVhbnVwKCkgY2FsbHMga3ZmcmVl
KGpvYi0+dGFza3MpIGFnYWluLCByZXN1bHRpbmcgaW4gYQpkb3VibGUtZnJlZS4KClNldCByam9i
LT50YXNrcyB0byBOVUxMIGFmdGVyIGZyZWVpbmcgaXQgaW4gcm9ja2V0X2NvcHlfdGFza3MoKSBz
bwp0aGF0IHRoZSBzdWJzZXF1ZW50IGt2ZnJlZSgpIGluIHJvY2tldF9qb2JfY2xlYW51cCgpIGlz
IGEgc2FmZSBuby1vcC4KCkZpeGVzOiAwODEwZDVhZDg4YTEgKCJhY2NlbC9yb2NrZXQ6IEFkZCBq
b2Igc3VibWlzc2lvbiBJT0NUTCIpClNpZ25lZC1vZmYtYnk6IERoYWJhbGVzaHdhciBEYXMgPGRo
YWJhbDEyM0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9hY2NlbC9yb2NrZXQvcm9ja2V0X2pvYi5j
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2FjY2VsL3JvY2tldC9yb2NrZXRfam9iLmMgYi9kcml2ZXJzL2FjY2VsL3JvY2tldC9yb2Nr
ZXRfam9iLmMKaW5kZXggYWJjZGVmMS4uMTIzNDU2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY2Nl
bC9yb2NrZXQvcm9ja2V0X2pvYi5jCisrKyBiL2RyaXZlcnMvYWNjZWwvcm9ja2V0L3JvY2tldF9q
b2IuYwpAQCAtMTAxLDYgKzEwMSw3IEBAIHN0YXRpYyBpbnQgcm9ja2V0X2NvcHlfdGFza3Moc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGRybV9maWxlICpmaWxlLAoKIGZhaWw6CiAJa3Zm
cmVlKHJqb2ItPnRhc2tzKTsKKwlyam9iLT50YXNrcyA9IE5VTEw7CiAJcmV0dXJuIHJldDsKIH0K
--000000000000f022500652cd8029
Content-Type: application/octet-stream; name="Bug2_patch1_null_deref.patch"
Content-Disposition: attachment; filename="Bug2_patch1_null_deref.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mpo5vs6w1>
X-Attachment-Id: f_mpo5vs6w1

RnJvbTogRGhhYmFsZXNod2FyIERhcyA8ZGhhYmFsMTIzQGdtYWlsLmNvbT4KRGF0ZTogV2VkLCAy
OCBNYXkgMjAyNiAwMDowMDowMCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBhY2NlbC9yb2Nr
ZXQ6IEFkZCBOVUxMIGNoZWNrIGZvciBkb21haW4gaW4gcm9ja2V0X2pvYl9jbGVhbnVwKCkKCklu
IHJvY2tldF9pb2N0bF9zdWJtaXRfam9iKCksIGlmIHJvY2tldF9jb3B5X3Rhc2tzKCkgb3IKZHJt
X2dlbV9vYmplY3RzX2xvb2t1cCgpIGZhaWxzLCB0aGUgZXJyb3IgcGF0aCByZWFjaGVzCnJvY2tl
dF9qb2JfY2xlYW51cCgpIHZpYSByb2NrZXRfam9iX3B1dCgpLiByb2NrZXRfam9iX2NsZWFudXAo
KQp1bmNvbmRpdGlvbmFsbHkgY2FsbHMgcm9ja2V0X2lvbW11X2RvbWFpbl9wdXQoam9iLT5kb21h
aW4pLCBidXQKam9iLT5kb21haW4gaXMgb25seSBhc3NpZ25lZCBhZnRlciBhbGwgdGhlIGZhbGxp
YmxlIG9wZXJhdGlvbnMuIFNpbmNlCnRoZSBqb2Igc3RydWN0IGlzIHplcm9lZCBieSBremFsbG9j
LCBqb2ItPmRvbWFpbiBpcyBOVUxMIG9uIGVhcmx5CmZhaWx1cmUsIGNhdXNpbmcgYSBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UgaW4Kcm9ja2V0X2lvbW11X2RvbWFpbl9wdXQoKSB3aGljaCBjYWxs
cyBrcmVmX3B1dCgpIG9uIGEgTlVMTCBwb2ludGVyLgoKQWRkIGEgTlVMTCBjaGVjayBiZWZvcmUg
Y2FsbGluZyByb2NrZXRfaW9tbXVfZG9tYWluX3B1dCgpLgoKRml4ZXM6IDA4MTBkNWFkODhhMSAo
ImFjY2VsL3JvY2tldDogQWRkIGpvYiBzdWJtaXNzaW9uIElPQ1RMIikKU2lnbmVkLW9mZi1ieTog
RGhhYmFsZXNod2FyIERhcyA8ZGhhYmFsMTIzQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2FjY2Vs
L3JvY2tldC9yb2NrZXRfam9iLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNjZWwvcm9ja2V0L3Jv
Y2tldF9qb2IuYyBiL2RyaXZlcnMvYWNjZWwvcm9ja2V0L3JvY2tldF9qb2IuYwppbmRleCBhYmNk
ZWYxLi4xMjM0NTY3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjY2VsL3JvY2tldC9yb2NrZXRfam9i
LmMKKysrIGIvZHJpdmVycy9hY2NlbC9yb2NrZXQvcm9ja2V0X2pvYi5jCkBAIC0yMzMsNyArMjMz
LDggQEAgc3RhdGljIHZvaWQgcm9ja2V0X2pvYl9jbGVhbnVwKHN0cnVjdCBrcmVmICpyZWYpCiAJ
c3RydWN0IHJvY2tldF9qb2IgKmpvYiA9IGNvbnRhaW5lcl9vZihyZWYsIHN0cnVjdCByb2NrZXRf
am9iLAogCQkJCQkJcmVmY291bnQpOwogCXVuc2lnbmVkIGludCBpOwoKLQlyb2NrZXRfaW9tbXVf
ZG9tYWluX3B1dChqb2ItPmRvbWFpbik7CisJaWYgKGpvYi0+ZG9tYWluKQorCQlyb2NrZXRfaW9t
bXVfZG9tYWluX3B1dChqb2ItPmRvbWFpbik7CgogCWRtYV9mZW5jZV9wdXQoam9iLT5kb25lX2Zl
bmNlKTsKIAlkbWFfZmVuY2VfcHV0KGpvYi0+aW5mZXJlbmNlX2RvbmVfZmVuY2UpOwo=
--000000000000f022500652cd8029--
