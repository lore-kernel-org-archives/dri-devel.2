Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C5CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 20:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A757610E3DA;
	Tue, 19 May 2026 20:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="lYgXpZ5H";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="gQvgOzX+";
	dkim-atps=neutral
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3939C10E31E
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+/HYbekN88tW98e+2mn2hG/TZbXhaP5H/gJm+hKZZ/I=; b=lYgXpZ5HZe/POAscpvaOtuXLP9
 73NOY0qPgnM6XDL/pBW3TUC8Cun6s0wsnZgA3CQI9d09wyqfRwY5C4AnMa8PcPb8YPVq1JUUfieoQ
 V24hClZoQ/Kw6ToWNXewmDenV/kxJHfAyFVDSZrXdncFrHFTeGIPiztF0xcH8q8Iu1I5ZY7E/3X8m
 cwFmN9B5vlrk4kW+va6KogZn4bXVxf4Aq8/xoV76THZ1VBd0aYTnWxmeAvHscdzEhm7FdgNW5sLnW
 x7zKjIV8yGTNvk/7T3QgPmSvs4zqVzVv+6bBwvSSDDY+n5VTF907WWLVMHHIItVFFUOL3i0eQo1Nq
 QrJMIjag==;
Received: from localhost by mail-01.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wPQy4-006C4e-0h;
 Tue, 19 May 2026 20:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222178; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=+/HYbekN88tW98e+2mn2hG/TZbXhaP5H/gJm+hKZZ/I=;
 b=gQvgOzX+D8utY5FtNZXuuizs9Sb+2nCge5SSXiiQKsJm332kylpqXMApyoNAilwqz3iTU
 uYBdoiCjfOOVioebArKTzVTaFuZY+RSNZ9+fivSfBDvt+C4CGqeUDFyLj6km/dZGVm2XcWs
 6WdHrYVSgjLJDNrcLROwyvcEZwiyX6CEieYNqJ/ZC2VvTv29ZesH1zoFSCy4uzfZkr+Y37U
 7wTTs8Z6ItHHpHqUsQu80Lm1y6yBByhgbbT+0DKZnQJZM71MLpVKYa7UDsT6J6yyqmUk8qD
 NdlGLLkEL3oP8DrJxhJ3oPmnnvSOrcNxZgVU5CMD+/M/JA3h5bSzEtsKDy9A==
From: Berkant Koc <me@berkoc.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 K. Y. Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
Date: Tue, 19 May 2026 22:20:28 +0200
Message-ID: <v3-reply-04-reply2.1779222028@berkoc.com>
In-Reply-To: <SN6PR02MB415761EE7992EAFA14F2201BD4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-cover-v2@berkoc.com>
 <20260517-drm-hyperv-patch2-v2@berkoc.com>
 <SN6PR02MB415761EE7992EAFA14F2201BD4002@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

Hello Michael,

Thanks for the thorough review. v3 is on the list and addresses each
point:

> Does copying the full 16 KiB break anything? Or are you flagging as just
> wasteful activity?

It is the residue read that is the actual hazard, not the copy cost:
the consumer that wakes on complete() then reads up to 16 KiB of bytes
the host did not write in this packet as if it were the response
payload. The v3 commit message now leads with that and treats
"wasteful" as a secondary observation.

> Version related comments should go below the "---" following the
> Signed-off line.

Moved into the cover letter changelog in v3 so it stays out of git
log.

> The check against VMBUS_MAX_PACKET_SIZE shouldn't be needed.

Dropped. The v3 check is bytes_recvd < hdr_size only.

> In similar cases in other drivers that have been hardened for CoCo VMs,
> the code outputs a rate limited error message. [...] See
> hv_kvp_onchannelcallback() for example.

Done in v3 via drm_err_ratelimited() on every short-packet path
(synthvid header underflow, type-specific payload underflow, feature
change underflow). The driver already uses drm_err_ratelimited() in
hyperv_sendpacket() for the corresponding send path.

> Additional logic is needed here. Each of the three message types
> in the "if" statement has data beyond just the header. Before doing
> the memcpy() and complete(), the code should validate that the msg
> is big enough to contain that expected data.

Fixed in v3. For the three completion types I now compute the required
payload size with a switch on msg->vid_hdr.type and reject the packet
before memcpy/complete:

  SYNTHVID_VERSION_RESPONSE    -> sizeof(struct synthvid_version_resp)
  SYNTHVID_RESOLUTION_RESPONSE -> sizeof(struct synthvid_supported_resolution_resp)
  SYNTHVID_VRAM_LOCATION_ACK   -> sizeof(struct synthvid_vram_location_ack)

The memcpy then uses bytes_recvd, so wait_for_completion_timeout()
consumers never see truncated data and never read past what the host
wrote.

Series: <cover.1779221339.git.me@berkoc.com>

The v3 patches carry an `Assisted-by: Claude:claude-opus-4-7
berkoc-pipeline` trailer per the kernel coding-assistants policy.
Code, analysis and review responses are mine; the model is used as
a structured reviewer under human verification.

Thanks,
Berkant
