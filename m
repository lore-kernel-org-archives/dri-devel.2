Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0F606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rAUFJ5AH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E787110E267;
	Tue, 20 Oct 2026 14:56:36 +0000 (UTC)
Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C1710E789
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:56:30 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=rhVJSNRvE7OKuKBfyX0DSPx+6p9/cmtC0eJ63r3tTIM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792508188; v=1; x=1793112988;
 b=rAUFJ5AHtoE0AUdS61bQ0UJBDQWt2Aqv0FJnZSdkSYCiifI90kbbY+oCtqd/cUUSWIzSg7qo
 I19ebhjN+0+rKFn/N8R2top1woiEvsYy8H7rnv2wfs5+zdjq9V0Q1uFGP7TrihP5jgbLYCOCcl8
 /4tP5yAdSpePD1+JiUnPOSPs=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 8f697e2a16de64c8;
 Tue, 20 Oct 2026 14:56:28 +0000
X-Mizu-Trace-ID: 8f697e2a16de64c8
X-Migadu-Flow: FLOW_OUT
From: Alvin Sun <alvin.sun@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
    dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 09/11] rust: device: expose dma_coherent()
In-Reply-To: <DLS0QEPJKOPZ.1MX607W2OQ0RI@kernel.org>
Date: Tue, 20 Oct 2026 22:55:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-ID: <5a350d4519eaf9c8.1792508188@smtp.migadu.com>
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
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Danilo,

On Tue, Sep 29, 2026 at 08:40:25PM +0200, Danilo Krummrich wrote:
> Why not return a transparent wrapper around enum dev_dma_attr so we have all cases covered?

Done in v4. The series also builds on your drm-file and sync series;
I rebased these on the current drm-rust-next and pushed the branch to:
https://gitlab.freedesktop.org/alvinsun039/linux/-/tree/tyr-ioctls

Best regards,
Alvin
