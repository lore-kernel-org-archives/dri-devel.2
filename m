Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D810EEBFD37
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 11:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7C110E339;
	Mon, 13 Apr 2026 11:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LLJKG2Md";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E94710E339
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:05:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05E3160180;
 Mon, 13 Apr 2026 11:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D91C116C6;
 Mon, 13 Apr 2026 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776078301;
 bh=EW7/I7t0wKFYsBLyPf41BSms1G0EuhpLPw78KMfPKaM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LLJKG2Md63iATpumkFQbaSa1gOtfuxt5qjbm0o/a5p4fzet++IWoNetlNgeZn9q+2
 4BnA8nxFAl5p+cjgTALQNzJNb+++/xPPpQZDV+2q9oEcOQFoA6jhaOyETt5SPzEdXo
 rDi99P4Z7l9QzpI2vxTCOmfdb3UMBgNE7JLBdaRA7pzr2MYp8RRWt7c/2ysvS+LWqU
 HHoiSu902etlonFqLdr2fVkTKG1wB5EGqgoQXqkHcNUfZkgS/MpB5SwAB5ecD1N/5t
 SOZwvcnHRq4GLmDgQGQMNFvdCEJJ/WF4PwYoO8On47ujCCf4GgKbotxnV0l2EOZHBD
 SQnpRtFVO08WA==
Date: Mon, 13 Apr 2026 16:34:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: Kishore Batta <kishore.batta@oss.qualcomm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, andersson@kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v4 2/9] bus: mhi: Move sahara protocol driver under
 drivers/bus/mhi
Message-ID: <sab2tgxtiftme5gscknsl7cfifpshtlrnnihbm2g56ppbowcit@bg4bzwuta6a6>
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-2-47ad79308762@oss.qualcomm.com>
 <0a2af0d1-27da-4f60-952a-409a5abc5647@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a2af0d1-27da-4f60-952a-409a5abc5647@oss.qualcomm.com>
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

On Thu, Apr 09, 2026 at 02:20:02PM -0600, Jeff Hugo wrote:
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
> > The Sahara protocol driver is currently located under the QAIC
> > accelerator subsystem even though protocol itself is transported over the
> > MHI bus and is used by multiple Qualcomm flashless devices.
> > 
> > Relocate the Sahara protocol driver to drivers/bus/mhi and register it as
> > an independent MHI protocol driver. This avoids treating Sahara as QAIC
> > specific and makes it available for reuse by other MHI based devices.
> > 
> > As part of this move, introduce a dedicated Kconfig and Makefile under the
> > MHI subsystem and expose the sahara interface via a common header.
> 
> I don't think this belongs under MHI. Mani needs to confirm that he agrees
> with the concept of moving this there.
> 
> The Sahara protocol as defined by the spec does not require MHI. We know
> that there are Sahara implementations over USB. I don't see a dependency or
> relationship to MHI other than the current in-kernel implementation uses
> MHI, but there are plenty of things that use MHI (qaic, mhi-net, ath12k,
> etc) which are not a part of the MHI bus.
> 

Since Sahara is a MHI client driver, it is OK with me to place it under
drivers/bus/mhi/host/. We do tend to host the client/controller drivers if they
also bind to separate top level subsystems like Net, WWAN... but for the pure
protocol drivers like Sahara, MHI can provide asylum.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
