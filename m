Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC360A6F6E
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm2 header.b=SpSiW7s+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=P1CdkiA9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6003A10FAEC;
	Wed, 21 Oct 2026 08:40:12 +0000 (UTC)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5C610FAEC
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:40:01 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 4CF08EC022F
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:40:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 04:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1792572000; x=1792658400; bh=ZRUeWVeHt3KCRBuFS0NAoBYETxLevSo2
 XjNeGZqmbtA=; b=SpSiW7s+Nn7tcFzU8ApWsri6ykt+yKJU2IJ11tSa/+ULYhAm
 Y5wuNjiq+A5bWC5M+YJDkx+CcV6v088ty27LniFhPU9pvF7gJidnIOeD17jNF6ex
 uCgDncXKzLSS2gHbu3pEpfuMBEhnarsoVukT4F/m0mwNlJd8qyhiaovMJ2kYCdlI
 l94VmO8JmUpEk59zqvTW1SVfvQIVJJsqrBHnxx2K8hUVtGba+MwSNgZWksYuxCEa
 ji8siuWUQW6mtO/I/jAHlKMiKa58no9FscnJZyXDCy0Ok4Ho9ElbGiIQNhj6hjm+
 ZuTfBNeBFl3AIdWba7Y28vFwCh4j7dibeJ1dWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1792572000; x=1792658400; bh=ZRUeWVeHt3KCRBuFS0NAoBYETxLe
 vSo2XjNeGZqmbtA=; b=P1CdkiA9KGQuE9gesSdZIHAFUiDG/61ceBsQ0opr4uVi
 G52b0OwP8ivtfXqCCb57Sp7aZMfXSYOfVJSfqdG+Qxc/AmeqJJ/AEbT8yVgS7h9v
 b7XeGjBgnESbCt595MTdX9V7jjJs0NhZZNtt2n9WQzopNot+btMxu8IdbOh623yF
 oimQ10jjEDN4V7Uli+rfOf2LWluYn7OZKUuoTmw9/Vles7AUdK6nNmybcRWVQVP7
 KiqD2WVmHejzjwoI0oYd7kpC+eImoDSpbd/XeCk/knVj5FcLtaLJKpJaaa3dEKHE
 rMZy4wr/PBGy7s9NjONyjYDrUiNVge6kTqICiywa7w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792572000; d=invisiblethingslab.com;
 mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:X3h2FOhLtNcIXYQgyTflfU4O8X1PTq0DVtOACEG5VRU5ihc
 PVUqnvZMq61OpXX1Sdk7L+3b7iOI+E7wSv0EdA8iA+BihjnqFjPoeHpxay7Hvmlb
 cpCh3lBY9F0kXAXbbkD86GjekG62WkTRnxRC4O5+7NpSxwL3f0YR/EjriANZTscs
 h8GohhH6Qvufnq9Ptb98pPz36KatO3P90R7MgIJpGWoSp5HwZPz7CsGCU3nXwlLd
 RhA94KKFrY3sVrX6imtv0M41yQrmG/rI2/Xvt3WkHbL04I9nKfOcwmXdod+knfDn
 NhQhwzm7zY5UWyNswAkLI0WkV7XEnNYVRj02pAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:9XIRFcxfocIE7TTVobmGHzvCjgMsTJ70TPYynJ4ynA8=:mQpFvnuWRf6RbeXO/lVQ3BUGGu0Nam8GMc33D7LIjIM=;
X-ME-Sender: <xms:X3rYanRpIsL5XFyp98M2QZ7J9GR-cTyskl-z8zuaEpsw8gBh_zclHw>
 <xme:X3rYag8vxyS5rq64pIuRTswT7k21qH2K-37-Ldx4C-Xb8teN-_EaSdOw_6PNuCUqt
 mHY4I4iFclUYsVgeAYJd7_je5ue14P88rmbNgmnBK9tMLjQot_E>
X-ME-Received: <xmr:X3rYaoZFZYqO7qRps79mqO-sSB-tfLhds5jPtQg7AuPUj7uQh9uF9uer6898qX1vAbvVAeKU_HQ5KZM3IhzQ2udPaXdeFoCuo3bKBfem6EMICRroQebWz3XA8mz11A>
X-ME-Proxy-Cause: dmFkZTGQ99FzaVuFTcvMdK/ygBNkRoPov9AfgImip9FZDA/maXGAfMDJmGK8CAXzpiT/v/
 6eSXOenWvT9pkl6/ECj5SYWG+7ulldBorjx2rxo5QgDzY5TFFln7KzFQOe2r+BInkFtah5
 lXwZrDGmtZlTphqhH3hkG8JCQ9e1Zj5KCBMd82t+JjBKm297UYGmJHlXDicWsY0O+mUCjX
 wBdfh5nJowniELGh1LYyawBXXlPkdvXsLmgOZjf52NEHmw63iZeiRd7otZZjTrBnx1UJpt
 2Khf1IgTOPArXIlvxTSUhdE9+G8iG1/NDCOzU602U8lg9kR2yn/YlHD2QaNB7FN+ZxDnZB
 3JrTVir4YpDM52ovWN9A7bgrFsQ2KF28DzUrD/e9wI7UOX7D2AR6egtR8cHaDZEPMBFPwc
 m1BiwjA3SmdNcP1LWBtbmhQqYXRT/cJh+lQo360yNhfVcaOJFkMAMw5tv/ojvc2GIvYhhp
 +wjrdaW4Xqb2wLe+LwTjLpU+2OB7P2ukWYF4uNJWux1m88t50dcGBGPW1BijNy8L+NibqA
 fjwlVRgWGREryBH1q+r3ioUNt/x9r36AOyADq7lLFpn2RN8irqFfaXpwEn4PQOQdwJt+Gy
 cuXsL/OmqEHNdFYFJi20QxPfSrSmO5vSEvoGOH5SR7M/v/gXg+v1DH8oaykQ
X-ME-Proxy: <xmx:X3rYahqElZfDGGf2n8k9vHJKnJ0qz9Orore7_YdQQi6fY7yw0tyyGA>
 <xmx:X3rYasTenipPpFc-EdSwvZIETSe8qJm3jDdG3ds8xvKGOhfPv2vU4w>
 <xmx:X3rYalrEXS36eZ09bgP36d1jGNOuHfI2Jh_rMLEYTuWQNVe2vseMRw>
 <xmx:X3rYam2RGG518CBgXgcxq3uutWgLPfs7m8-ucqOSy5XJGvMF0QdCkA>
 <xmx:YHrYahFsmM0DAG6FnHKtSsaD1V-ctWmyP-5PPdMN1vr3V8BicGXP3TG8>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:39:57 -0400 (EDT)
From: Val Packett <val@invisiblethingslab.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: Val Packett <val@invisiblethingslab.com>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] udmabuf: Improve list length limit handling
Date: Wed, 21 Oct 2026 05:39:10 -0300
Message-ID: <20261021083933.1983894-1-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v2: Set a reasonable size, and fix size overflow check (Christian)
    I've put the check into a separate patch that's Cc'ed to stable
    and has a Fixes tag since it has been an issue since the size
    has been allowed to be changed via tunables and the condition
    has been reachable like that, independent of me changing the
    default value..
v1: https://lore.kernel.org/all/20261006005053.2245156-1-val@invisiblethingslab.com/

Val Packett (2):
  udmabuf: Fix list length overflow check
  udmabuf: Increase the default list length limit

 drivers/dma-buf/udmabuf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.55.0

