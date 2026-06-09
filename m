Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A23CD8CAC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B0F10E105;
	Tue,  9 Jun 2026 06:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VfYS26O7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BC310E105
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:57:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4287B43767;
 Tue,  9 Jun 2026 06:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD4B1F00893;
 Tue,  9 Jun 2026 06:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988243;
 bh=5OLcB8IoeIiXDSK0W4AKNSHVxFgeQ0bf3IWxbTtLYCI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VfYS26O7yyONf85xRggrb87R6M2VOztsujuc3MbAljqQVerQtTwaAWFCx6oP4d5QL
 erE2FyXNeO2WUk6WLmD2SGEKGfpLoFBskcIRfRwEXICW/MWhYlkgTPExURHo+tkWBr
 dppis83VjwQBna9Av0z6UcepwgNE2jJBOmkMDvru3fXr5PRIp0E61xGldv0qLovCAO
 agKzIsFSfN/xhVD8Ox4p/X1RigByrpsRSuHVmo1JZtPpLmmCNrb4iRoUhqYdsbklRm
 kY9fesmxN6v3F4qK+VAk/HK0FZT+jw79hvaDhc0pdCjm+pyzw7pyZTCJubpgPyqeJ5
 8QePMScCe5kJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] spi: tegra210-quad: Open-code message transfer
 walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609063855.95710-1-kaitao.cheng@linux.dev>
References: <20260609063855.95710-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:57:22 +0000
Message-Id: <20260609065722.EAD4B1F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware Chip Select (CS) is left asserted indefinitely if the fin=
al message transfer is absorbed as a dummy transfer.
- [High] DMA memory mapping leak on error paths in `tegra_qspi_start_dma_ba=
sed_transfer`.
- [High] DMA memory mapping leak upon transfer timeout or hardware error.
- [High] DMA maps memory beyond the end of the SPI transfer buffer when usi=
ng packed DMA transfers.
- [High] Unconditional DMA unmap on error path in `tegra_qspi_dma_map_xfer`.
--

commit dedc4ce6598360fa2a4de3d4413aaecfda3051a4
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

spi: tegra210-quad: Open-code message transfer walk

This commit converts the list_for_each_entry() loop in
tegra_qspi_non_combined_seq_xfer() to an open-coded for-loop. This
preserves semantics when consuming the next transfer in the loop body,
preparing the code for future list iterator updates.

> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-q=
uad.c
> index 588a929a97850..102562893d227 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -1309,7 +1309,9 @@ static int tegra_qspi_non_combined_seq_xfer(struct =
tegra_qspi *tqspi,
>  	if (tqspi->soc_data->supports_tpm)
>  		val &=3D ~QSPI_TPM_WAIT_POLL_EN;
>  	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
> -	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
> +	for (transfer =3D list_first_entry(&msg->transfers, typeof(*transfer), =
transfer_list);
> +	     !list_entry_is_head(transfer, &msg->transfers, transfer_list);
> +	     transfer =3D list_next_entry(transfer, transfer_list)) {
>  		struct spi_transfer *xfer =3D transfer;
>  		u8 dummy_bytes =3D 0;
>  		u32 cmd1;

[Severity: High]
This is a pre-existing issue, but does this logic fail to deactivate the
chip select if the final transfer is absorbed as a dummy transfer?

In tegra_qspi_non_combined_seq_xfer(), if the final SPI transfer in the
message is a dummy transfer, the loop pointer advances to it, effectively
consuming it into the current xfer:

    if (next_xfer->dummy_data) {
        ...
        transfer =3D next_xfer;
    }

When checking if CS should be deactivated at the end of the loop body,
the code uses xfer instead of the updated transfer pointer:

    if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
        if (!xfer->cs_change) {
            tegra_qspi_transfer_end(spi);
            ...
        }
    } else if (xfer->cs_change) {
        ...

Since xfer is the second-to-last transfer, list_is_last() evaluates to
false. The code falls through to the else branch, and if cs_change is
false, tegra_qspi_transfer_end() is skipped.

The loop then terminates, leaving the hardware chip select asserted
indefinitely. Could this corrupt subsequent bus communications?

[Severity: High]
This is a pre-existing issue, but do we leak DMA memory mappings if a
transfer times out or encounters a hardware error?

Looking at tegra_qspi_non_combined_seq_xfer(), if the transfer times out,
tegra_qspi_handle_timeout() confirms the timeout, stops the DMA engine
channels, and jumps to complete_xfer:

    if (tqspi->is_curr_dma_xfer)
        tegra_qspi_dma_stop(tqspi);
    ...
    goto complete_xfer;

Similarly, if a hardware error is detected, we also jump to complete_xfer:

    if (tqspi->tx_status || tqspi->rx_status) {
        ...
        goto complete_xfer;
    }

In both paths, the code exits without calling tegra_qspi_dma_unmap_xfer().
Are these DMA mappings permanently leaked?

[Severity: High]
This isn't a bug introduced by this patch, but does
tegra_qspi_start_dma_based_transfer() leak DMA memory mappings on its
error paths?

When tqspi->is_packed is true, tegra_qspi_dma_map_xfer() successfully
maps the TX and RX DMA buffers.

If any subsequent DMA setup operations fail (like dmaengine_slave_config(),
tegra_qspi_start_tx_dma(), or tegra_qspi_start_rx_dma()), the function
returns the error directly:

    ret =3D dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
    if (ret < 0) {
        dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
        return ret;
    }

The caller tegra_qspi_non_combined_seq_xfer() then propagates the error
and exits, never calling tegra_qspi_dma_unmap_xfer().

Does this permanently leak the DMA mapped memory and IOMMU space?

[Severity: High]
This is a pre-existing issue, but does the DMA mapping calculation risk
crossing an unmapped physical page boundary?

In tegra_qspi_dma_map_xfer(), when tqspi->is_packed is true, the mapped
length is artificially inflated to a multiple of 4:

    len =3D DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) =
* 4;

    if (t->tx_buf) {
        t->tx_dma =3D dma_map_single(tqspi->tx_dma_dev, (void *)tx_buf,
                                   len, DMA_TO_DEVICE);

Because the original client-provided buffer might be exactly t->len bytes
long, mapping beyond its exact length could cross into restricted or
unallocated physical memory.

Could this trigger an IOMMU fault or a kernel panic?

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
tegra_qspi_dma_map_xfer() unconditionally unmap the TX buffer even when
it was never mapped?

If t->tx_buf is NULL during a read-only transfer, the TX buffer mapping
is correctly skipped.

However, if the subsequent dma_map_single() for t->rx_buf fails, the
error handling block unmaps tx_dma without checking:

    if (dma_mapping_error(tqspi->rx_dma_dev, t->rx_dma)) {
        dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma, len, DMA_TO_DEVICE);
        return -ENOMEM;
    }

Since t->tx_buf was NULL, t->tx_dma was never mapped by this function.

Could unmapping it here violate the DMA API contract, potentially
unmapping page 0 from the IOMMU or corrupting DMA tracking state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D10
