Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68098109C055
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89F410E297;
	Wed, 25 Mar 2026 18:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e5l+Ee0R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 597EB10E297;
 Wed, 25 Mar 2026 18:29:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2773341778;
 Wed, 25 Mar 2026 18:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF88BC4CEF7;
 Wed, 25 Mar 2026 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774463383;
 bh=966frQpB0Xm9H/0AdYnqSQQxIaoxgv3Ygysz2Iqg460=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=e5l+Ee0R3CieZrRr0oTRo8YO6Qki9lHTFUDxUxECwLN/Xs6AOrhfkH3AWjGfkIY57
 VfloT6LBSYi7W/+k1YXBZV8CiQahvo5g/fStJwcg/suq0XyQ3/MjNGrOKk2S4ccIB2
 EzTuT9BCmg1N6WX1rLoWUQPgZE1m4tAFRJ8H/Z9VjgGlflWpHVWKsxRFlZDECAosMI
 Wm8pvApYCW1mYDLCHO54o3+rB9972XVuOPV58ieFl3zZ/GcTXcBReQiRjNd3bOguk3
 aVIKYpjgoJZuGmGvfPTZZjAq0pvrqwb0b93beGSMdPgSctXojpnqfzY5zmO0rQMWhU
 6bodlR/eyf10w==
Date: Wed, 25 Mar 2026 13:29:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/5] vgaarb: pass vga_get_uninterruptible() errors to
 userspace
Message-ID: <20260325182941.GA1196515@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005254cb-6070-488d-a548-9ac10df568a9@hogyros.de>
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

On Wed, Mar 25, 2026 at 03:52:37PM +0900, Simon Richter wrote:
> Hi Bjorn,
> 
> On 3/25/26 4:37 AM, Bjorn Helgaas wrote:
> 
> > > If VGA routing cannot be established, vga_get_uninterruptible() returns an
> > > error and does not increment the lock count. Pass the error on, and don't
> > > call vga_put() when userspace closes the handle.
> 
> > I applied this, but I'm a little confused about the "don't call
> > vga_put() when userspace closes the handle" part.  Does that happen in
> > this patch and I'm just missing it?  This patch changes the "lock"
> > case, and the only vga_put() call I see is in the "unlock" case.
> 
> By not locking, we're not incrementing uc->io_cnt and uc->mem_cnt, so the
> release will not call vga_put().

Thanks, added this to the commit log:

  If VGA routing cannot be established, vga_get_uninterruptible() returns an
  error and does not increment the lock count. Return the error to the
  caller.

  Return before incrementing uc->io_cnt/mem_cnt so vga_arb_release() won't
  call vga_put() when userspace closes the handle.

